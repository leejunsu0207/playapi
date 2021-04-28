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

        return temp;
    }

    @Override
    public int[][] getLottoRandomNumbers(String gameCount){
        int num = Integer.parseInt(gameCount);
        int [][]lotto = lottonumbers(num);

        return lotto;
    }

    private String lottoNumbers() {
        Set<Integer> set = new HashSet<Integer>();

        while (set.size() != 6) {
            set.add((int) (Math.random() * 45 + 1));
        }

        List<Integer> list = new ArrayList<Integer>(set);
        Collections.sort(list);
        return list.toString();
    }

    private int[][] lottonumbers(int num){
        int game = num;//게임수

        int[][] lotto = new int[game][6];//로또번호를 저장할 공간

        System.out.println();
        for(int i=0; i<game; i++){//game개 만큼 반복
            for(int j=0; j<lotto[i].length; j++){// 6번 반복
                lotto[i][j] = (int)(Math.random() * 45) + 1;//1~45숫자중 하나
                for(int k=0; k<j ; k++){
                    if(lotto[i][j] == lotto[i][k]){//같은 숫자가 있는지 비교
                        j--;
                        break;
                    }
                }// end for k
            }//end for j 로또번호 한세트를 만들었다...


            //세트끼리 비교
            for(int k=0; k<i; k++){//현재세트보다 작은것들..
                int cnt = 0;//같은수의 갯수
                for(int m=0; m<lotto[i].length; m++){// 6번 반복
                    for(int n=0; n<lotto[k].length; n++){// 6번 반복
                        if(lotto[i][m] == lotto[k][n]){
                            cnt++;
                            break;
                        }
                    }//end for n
                    if(cnt != m+1){//같지않은 숫자가 포함. 나머지 비교필요무
                        break;
                    }
                }//end for m
                if(cnt ==  lotto[k].length){// 6개의 숫자가 일치할 경우
                    i--;
                    break;
                }
            }//end for k
        }//end for i

        //*************결과 출력*******************************
        for(int i=0; i<lotto.length; i++){
            System.out.print("\t" + (i + 1) + "번째 추천번호 => ");
            for(int j=0; j<lotto[i].length; j++){
                System.out.print(lotto[i][j] + "\t");
            }
            System.out.println();
        }
        System.out.println();

        return lotto;
    }




}
