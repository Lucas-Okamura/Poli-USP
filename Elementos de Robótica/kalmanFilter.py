# Exercício de Filtro de Kalman Extendido - PMR3502
# Nome: Lucas Hideki Takeuchi Okamura
# NUSP: 9274315

# Imports
import pandas as pd 
import numpy as np
import os
import matplotlib.pyplot as plt
import sys
#np.set_printoptions(suppress=True)

def LeDados(csvpath : str) -> pd.DataFrame:
    """Lê o csv com dados do sistema do robô triciclo e realiza pequenos tratamentos

    Args:
        csvpath (str): Caminho para arquivo csv

    Returns:
        pd.DataFrame: Data Frame com dados lidos
    """

    df = pd.read_csv(csvpath, names=["velocidade", "phi", "dist_antena", "bf", "be"])

    return df

def kalmanFilterNoMeasure(df_robot : pd.DataFrame,
                          mi_inicial : np.array,
                          sigma_inicial : np.array,
                          tempo_final : int,
                          dt : float,
                          l : float) -> (np.array, np.array, np.array, np.array, np.array, np.array)    :
    """
    Realiza o procedimento do filtro de Kalman para cálculo de estimativas sem considerar medições, 
    ou seja, mi = mi_barra e sigma = sigma_barra

    Args:
        df_robot (pd.DataFrame): dataframe que contém os dados do robô
        mi_inicial (np.array): matriz mi para o instante de tempo inicial
        sigma_inicial (np.array): matriz sigma para o instante de tempo inicial
        tempo_final (int): instante de tempo final em segundo
        dt (float): passo de iteração
        l (float): distância entre eixos do veículo

    Returns:
        x (np.array): vetor com coordenada x ao longo das iterações
        y (np.array): vetor com coordenada y ao longo das iterações
        theta (np.array): vetor com ângulo theta do robô com a horizontal ao longo das iterações
        fx (np.array): vetor com campo magnético local na coordenada x ao longo das iterações
        fx (np.array): vetor com campo magnético local na coordenada y ao longo das iterações
        sigma (np.array): matriz sigma no instante tempo_final
    """
    # Quantidade de iterações
    it = int(tempo_final / dt)
    # Estabelecendo variáveis
    x = np.append(np.array(mi_inicial.T[0]), np.zeros(it).T)
    y = np.append(np.array(mi_inicial.T[1]), np.zeros(it).T)
    theta = np.append(np.array(mi_inicial.T[2]), np.zeros(it).T)
    fx = np.append(np.array(mi_inicial.T[3]), np.zeros(it).T)
    fy = np.append(np.array(mi_inicial.T[4]), np.zeros(it).T)
    v = np.array(df_robot['velocidade'])
    phi = np.array(df_robot['phi'])
    rho = np.array(df_robot['dist_antena'])
    bf = np.array(df_robot['bf'])
    be = np.array(df_robot['be'])
    tempo = 0

    # Transpondo mi e mi_barra para o python tratar melhor
    mi = mi_barra = np.append(np.array([mi_inicial.T]), np.zeros((5, it)).T, axis=0)
    sigma = sigma_inicial

    for t in range(1, it + 1):
        # Calculando mi e mi_barra
        F = mi[t-1] + [v[t-1]*np.cos(theta[t-1])*dt, 
                          v[t-1]*np.sin(theta[t-1])*dt, 
                          (v[t-1]*np.tan(phi[t-1])*dt) / l, 
                          0, 
                          0]

        # Adicionando novo estado para mi_barra e mi, que são identicos
        mi_barra[t] = F
        mi[t] = F
        
        # Separando componentes de mi_barra / mi
        x[t] = mi[t][0]
        y[t] = mi[t][1]
        theta[t] = mi[t][2]
        fx[t] = mi[t][3]
        fy[t] = mi[t][4]

        # Calculando sigma
        At = np.array([[1, 0, -v[t-1]*np.sin(theta[t-1])*dt, 0, 0],
                       [0, 1, v[t-1]*np.cos(theta[t-1])*dt, 0, 0],
                       [0, 0, 1, 0, 0],
                       [0, 0, 0, 1, 0],
                       [0, 0, 0, 0, 1]])

        slt = dt * v[t-1] / 6
        srt = dt * v[t-1] / 12
        sthetat = dt * v[t-1] / (8 * l)

        Mrot = np.array([[np.cos(theta[t]), -np.sin(theta[t]), 0, 0, 0],
                       [np.sin(theta[t]), np.cos(theta[t]), 0, 0, 0],
                       [0, 0, 1, 0, 0],
                       [0, 0, 0, 1, 0],
                       [0, 0, 0, 0, 1]])

        R_local = np.array([[slt**2, 0, 0, 0, 0],
                      [0, srt**2, 0, 0, 0],
                      [0, 0, sthetat**2, 0, 0],
                      [0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0]])
        
        # Mudança de referencial
        R_global = Mrot @ R_local @ Mrot.T

        sigma_barra = (At @ sigma @ At.T) + R_global
        sigma = sigma_barra

        tempo += dt
        
        if tempo == tempo_final:
            print(f"Sigma no instante {tempo}: {sigma}")

    return x, y, theta, fx, fy, sigma

def kalmanFilterDefault(df_robot : pd.DataFrame,
                        mi_inicial : np.array,
                        sigma_inicial : np.array,
                        tempo_final : int,
                        dt : float,
                        l : float,
                        h : float) -> (np.array, np.array, np.array, np.array, np.array, np.array):
    """
    Realiza o procedimento do Filtro de Kalman Extendido completo

    Args:
        df_robot (pd.DataFrame): dataframe que contém os dados do robô
        mi_inicial (np.array): matriz mi para o instante de tempo inicial
        sigma_inicial (np.array): matriz sigma para o instante de tempo inicial
        tempo_final (int): instante de tempo final em segundo
        dt (float): passo de iteração
        l (float): distância entre eixos do veículo
        h (float): distância do robô até a antena

    Returns:
        x (np.array): vetor com coordenada x ao longo das iterações
        y (np.array): vetor com coordenada y ao longo das iterações
        theta (np.array): vetor com ângulo theta do robô com a horizontal ao longo das iterações
        fx (np.array): vetor com campo magnético local na coordenada x ao longo das iterações
        fx (np.array): vetor com campo magnético local na coordenada y ao longo das iterações
        sigma (np.array): matriz sigma no instante tempo_final
    """
    # Quantidade de iterações
    it = int(tempo_final / dt)

    # Estabelecendo variáveis
    x = x_barra = np.append(np.array(mi_inicial.T[0]), np.zeros(it).T)
    y = y_barra =  np.append(np.array(mi_inicial.T[1]), np.zeros(it).T)
    theta = theta_barra = np.append(np.array(mi_inicial.T[2]), np.zeros(it).T)
    fx = fx_barra = np.append(np.array(mi_inicial.T[3]), np.zeros(it).T)
    fy = fy_barra = np.append(np.array(mi_inicial.T[4]), np.zeros(it).T)
    v = np.array(df_robot['velocidade'])
    phi = np.array(df_robot['phi'])
    rho = np.array(df_robot['dist_antena'])
    bf = np.array(df_robot['bf'])
    be = np.array(df_robot['be'])
    z_t = np.array(df_robot[['dist_antena', 'bf', 'be']])
    tempo = 0

    # Transpondo mi e mi_barra para o python tratar melhor
    mi = mi_barra = np.append(np.array([mi_inicial.T]), np.zeros((5, it)).T, axis=0)
    sigma = sigma_inicial

    for t in range(1, it + 1):
        # Calculando mi e mi_barra
        F = mi[t-1] + [v[t-1]*np.cos(theta[t-1])*dt, 
                          v[t-1]*np.sin(theta[t-1])*dt, 
                          (v[t-1]*np.tan(phi[t-1])*dt) / l, 
                          0, 
                          0]

        # Adicionando novo estado para mi_barra e mi, que são identicos
        mi_barra[t] = F
        
        # Separando componentes de mi_barra
        x_barra[t] = mi_barra[t][0]
        y_barra[t] = mi_barra[t][1]
        theta_barra[t] = mi_barra[t][2]
        fx_barra[t] = mi_barra[t][3]
        fy_barra[t] = mi_barra[t][4]

        # Calculando sigma
        At = np.array([[1, 0, -v[t-1]*np.sin(theta[t-1])*dt, 0, 0],
                       [0, 1, v[t-1]*np.cos(theta[t-1])*dt, 0, 0],
                       [0, 0, 1, 0, 0],
                       [0, 0, 0, 1, 0],
                       [0, 0, 0, 0, 1]])

        slt = dt * v[t-1] / 6
        srt = dt * v[t-1] / 12
        sthetat = dt * v[t-1] / (8 * l)

        Mrot = np.array([[np.cos(theta_barra[t]), -np.sin(theta_barra[t]), 0, 0, 0],
                       [np.sin(theta_barra[t]), np.cos(theta_barra[t]), 0, 0, 0],
                       [0, 0, 1, 0, 0],
                       [0, 0, 0, 1, 0],
                       [0, 0, 0, 0, 1]])

        R_local = np.array([[slt**2, 0, 0, 0, 0],
                      [0, srt**2, 0, 0, 0],
                      [0, 0, sthetat**2, 0, 0],
                      [0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0]])

        # Mudança de referencial
        R_global = Mrot @ R_local @ Mrot.T

        sigma_barra = (At @ sigma @ At.T) + R_global

        # Abreviações
        cos = np.cos(theta_barra[t])
        sen = np.sin(theta_barra[t])

        # Medições
        G = np.array([[np.sqrt(x_barra[t]**2 + y_barra[t]**2 + h**2)],
                      [fx_barra[t] * cos + fy_barra[t] * sen],
                      [-fx_barra[t] * sen + fy_barra[t] * cos]])

        C = np.array([[x_barra[t] / (np.sqrt(x_barra[t]**2 + y_barra[t]**2 + h**2)), y_barra[t] / (np.sqrt(x_barra[t]**2 + y_barra[t]**2 + h**2)), 0, 0, 0],
                      [0, 0, -fx_barra[t] * sen + fy_barra[t] * cos, cos, sen],
                      [0, 0, -fx_barra[t] * cos - fy_barra[t] * sen, -sen, cos]])

        Q = np.array([[(h**2 + x_barra[t]**2 + y_barra[t]**2) / (20**2), 0, 0],
                      [0, 1/4, 0],
                      [0, 0, 1/4]])

        K = sigma_barra @ C.T @ np.linalg.inv(C @ sigma_barra @ C.T + Q)

        mi[t] = mi_barra[t] + (K @ ((z_t[t] - G.T).T)).T

        # Separando componentes de mi
        x[t] = mi[t][0]
        y[t] = mi[t][1]
        theta[t] = mi[t][2]
        fx[t] = mi[t][3]
        fy[t] = mi[t][4]

        # Calculando sigma
        I = np.identity(5)
        sigma = (I - (K @ C)) @ sigma_barra

        tempo += dt
        
        if tempo == tempo_final:
            print(f"Sigma no instante {tempo}: {sigma}")

    return x, y, theta, fx, fy, sigma

if __name__ == '__main__':
    # Recebendo inputs do usuário
    medida = input("Deseja observar apenas as estimativas (sim/nao)?: ")
    tempo_final = float(input("Insira o tempo final da simulação (máx. 1375s): "))

    if tempo_final > 1375.25:
        print("Insira um instante de tempo menor que 1375!")
        sys.exit()
    elif tempo_final % 0.25 != 0:
        print("Insira um instante de tempo múltiplo de 0.25!")
        sys.exit()

    # Lê arquivo csv
    filepath = os.path.dirname(os.path.abspath(__file__))
    csvpath = os.path.join(filepath, "valores.csv")
    df_robot = LeDados(csvpath)

    # Estabelecendo variáveis iniciais
    l = 0.3 # Distância entre eixos do veículo
    h = 0.5 # Altura da antena
    dt = 0.25 # Passo das iterações
    mi_0 = np.zeros(5) # mi para tempo 0
    sigma_0 = np.array([[0, 0, 0, 0, 0], # sigma para tempo 0
                        [0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 0],
                        [0, 0, 0, 10, 0],
                        [0, 0, 0, 0, 10]])

    if medida == 'sim':
        x, y, theta, fx, fy, sigma = kalmanFilterNoMeasure(df_robot, mi_0, sigma_0, tempo_final, dt, l)
        plt.plot(x, y)
        plt.title(f"Caminho percorrido pelo robô (Estimativa - Ex. 4 - {tempo_final}s)")
        plt.xlabel("Posição em x")
        plt.ylabel("Posição em y")
        plt.show()
    elif medida == 'nao':
        x, y, theta, fx, fy, sigma = kalmanFilterDefault(df_robot, mi_0, sigma_0, tempo_final, dt, l, h)
        plt.plot(x, y)
        plt.title(f"Caminho percorrido pelo robô (Filtrado - Ex. 6 - {tempo_final}s)")
        plt.xlabel("Posição em x")
        plt.ylabel("Posição em y")
        plt.show()
    
