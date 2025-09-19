#ifndef ORDENACAO_H
#define ORDENACAO_H

#include <vector>
using namespace std;

// Ordenação bolha
void bolha(vector<int>& lista, int &comparacoes, int &trocas) {
    comparacoes = 0;
    trocas = 0;
    bool houve_troca = true;
    while (houve_troca) {
        houve_troca = false;
        for (int i = 0; i < lista.size() - 1; i++) {
            comparacoes++;
            if (lista[i] > lista[i + 1]) {
                trocas++;
                int tmp = lista[i];
                lista[i] = lista[i + 1];
                lista[i + 1] = tmp;
                houve_troca = true;
            }
        }
    }
}

// Ordenação seleção
void selecao(vector<int>& lista, int &comparacoes, int &trocas) {
    comparacoes = 0;
    trocas = 0;
    for (int i = 0; i < lista.size() - 1; i++) {
        int posMenor = i;
        for (int j = i + 1; j < lista.size(); j++) {
            comparacoes++;
            if (lista[j] < lista[posMenor]) {
                posMenor = j;
            }
        }
        if (i != posMenor) {
            trocas++;
            int tmp = lista[i];
            lista[i] = lista[posMenor];
            lista[posMenor] = tmp;
        }
    }
}

// Ordenação inserção
void insercao(vector<int>& lista, int &comparacoes, int &trocas) {
    comparacoes = 0;
    trocas = 0;
    for (int i = 1; i < lista.size(); i++) {
        int tmp = lista[i];
        int j = i - 1;
        while (j >= 0 && tmp < lista[j]) {
            comparacoes++;
            lista[j + 1] = lista[j];
            trocas++;
            j--;
        }
        if (j >= 0) comparacoes++;
        lista[j + 1] = tmp;
        trocas++;
    }
}

#endif
