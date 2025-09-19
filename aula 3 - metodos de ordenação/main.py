def main():
    lista_aleatoria = popular_lista_aleatoria(100000)
    lista_sequencial = popular_lista_sequencial(100000)

    lista_aleatoria = ordenar_lista(lista_aleatoria)
    lista_sequencial = ordenar_lista(lista_sequencial)


if __name__ == "__main__":
    main()