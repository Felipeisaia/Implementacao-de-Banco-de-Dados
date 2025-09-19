def main():
    lista_numeros = []
    lista_palavras = []

    # números aleatórios
    Util.popular_lista_numeros_aleatorios(lista_numeros, 10, 50, 100)
    Util.exibir_lista_numeros(lista_numeros)

    # palavras aleatórias
    Util.popular_lista_palavras_aleatorio(lista_palavras, 10, 10)
    Util.exibir_lista_palavras(lista_palavras)

    # salvar em arquivos
    Util.popular_lista_numeros_arquivo(lista_numeros, "numeros.txt")
    Util.popular_lista_palavras_arquivo(lista_palavras, "palavras.txt")


if __name__ == "__main__":
    main()