package com.example.playapi.service.impl;

import com.example.playapi.service.LottoService;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class LottoServiceImpl implements LottoService {

    @Override
    public List<String> getLottoRandomNumber(String gameCount) throws Exception {
        List<String> temp = new ArrayList<>();
        int num = Integer.parseInt(gameCount);
        for (int i = 1; i <= num; i++) {
            temp.add(lottoNumbers());
        }
//        System.out.println(temp.toString());

        return temp;
    }

    private String lottoNumbers() {
        Set<Integer> set = new HashSet<Integer>();

        while (set.size() != 6) {
            set.add((int) (Math.random() * 45 + 1));
        }

        List<Integer> list = new ArrayList<Integer>(set);
        Collections.sort(list);
        return list.toString();
//        return list;
    }
}
