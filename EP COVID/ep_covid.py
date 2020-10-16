# Import de bibliotecas utilizadas
import pandas as pd
import matplotlib.pyplot as plt

# Lendo o arquivo csv
df = pd.read_excel("""HOJE_PAINEL_COVIDBR_13jul2020.xlsx""")
df = df.iloc[0:28]  # Apenas as primeiras colunas importam pois tem os dados por estado

# Definindo listas para guardar valores
estados = []
porcentagens = []
mortes = []

# Escolhendo o estado para avaliar os dados e printando o resultado
check = True
while check:
    try:            # Verifica se o estado digitado é valido
        estado = str(input("Digite a sigla do estado para ver as mortes por COVID-19 (valor acumulado). Caso deseje sair do programa, digite 0: "))
        if estado != "0":       # Condição para continuar no código
            morte = df.loc[df["estado"] == estado, ["obitosAcumulado"]].values[0]    # Obtém o valor da dataframe referente ao número de mortes acumulado
            populacao = df.loc[df["estado"] == estado, ["populacaoTCU2019"]].values[0]   # Obtém o valor da dataframe referente a população do estado
            porcentagem = round(100 * int(morte) / int(populacao), 3)     # Calcula a porcentagem de mortes em relação a população total e arredonda
            estados.append(estado)
            porcentagens.append(porcentagem)
            mortes.append(morte)
            print("O número total de mortes no estado de " + estado + " é de " + str(morte[0]))
            print("A porcentagem de mortes em relação a população do estado de " + estado + " é de " + str(porcentagem) + "%")
        else:
            check = False
    except IndexError:  # Mensagem de erro caso estado digitado não seja válido
        print("Digite um estado válido!")
    
# Gerando novo arquivo com dados obtidos
novo_df = pd.DataFrame({"Estado" : estados,
                        "Porcentagem de mortos": porcentagens})             # Dataframe que será transformada em arquivo csv

novo_df.to_excel("porcentagem_mortes.xlsx",index = False)

# Gerando os gráficos
data = df["data"][0]        # CSV é gerado para uma data apenas
for i in range(len(estados)):
    # Para o número de mortes
    plt.figure()
    plt.bar(data, mortes[i])
    plt.title("Número de mortes acumuladas no estado de " + str(estados[i]))
    plt.xlabel("Data")
    plt.ylabel("Mortes")
    plt.savefig("mortes_" + str(estados[i]))
    # Para a porcentagem de mortes
    plt.figure()
    plt.bar(data, porcentagens[i])
    plt.title("Porcentagem de mortes no estado de " + str(estados[i]))
    plt.xlabel("Data")
    plt.ylabel("Porcentagem de mortes (%)")
    plt.savefig("porcentagens_" + str(estados[i]))

