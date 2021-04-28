package com.example.playapi.service;

import java.util.List;


public interface LottoService {

    List<String> getLottoRandomNumber(String gameCount) throws Exception;

    int[][] getLottoRandomNumbers(String gameCount) throws Exception;

}
