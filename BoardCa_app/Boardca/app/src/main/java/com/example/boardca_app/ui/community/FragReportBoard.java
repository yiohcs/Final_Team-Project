package com.example.boardca_app.ui.community;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.example.boardca_app.R;

public class FragReportBoard extends Fragment {

    private View view;

    public static FragReportBoard newInstance(){
        FragReportBoard fragReportBoard = new FragReportBoard();
        return fragReportBoard;
    }



    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        view = inflater.inflate(R.layout.comm_reportboard, container, false);

        return view;
    }
}