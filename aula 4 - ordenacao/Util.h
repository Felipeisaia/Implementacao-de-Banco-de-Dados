#ifndef UTIL_H
#define UTIL_H

#include <iostream>
#include <vector>
#include <cstdlib> 

using namespace std;

// Função para popular lista com números aleatórios
void popular_lista(vector<int>& lista, int quantidade, int inicio, int fim) {
    for (int i = 0; i < quantidade; i++) {
        int num = inicio + rand() % (fim - inicio + 1);
        lista.push_back(num);
    }
}

// Função para exibir lista
void exibir_lista(const vector<int>& lista) {
    for (int i = 0; i < lista.size(); i++) {
        cout << lista[i] << " ";
    }
    cout << endl;
}

#endif
