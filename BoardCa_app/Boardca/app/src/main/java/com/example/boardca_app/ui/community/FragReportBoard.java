package com.example.boardca_app.ui.community;

import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.example.boardca_app.R;

public class FragReportBoard extends Fragment {

    private ViewGroup viewGroup;
    public String id = "id";
    public String nickname = "nickname";

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        viewGroup = (ViewGroup)inflater.inflate(R.layout.comm_reportboard, container, false);
        WebView webView = viewGroup.findViewById(R.id.comm_report);

        webView.getSettings().setJavaScriptEnabled(true);

        if(getArguments().getString("id") != null) {
            id = getArguments().getString("id");// 전달한 key 값
            Log.e("bbbbbbbb", id);
        }
        if(getArguments().getString("nickname") != null) {
            nickname = getArguments().getString("nickname");// 전달한 key 값
            Log.e("bbbbbbbb", id);
        }

        webView.setWebChromeClient(new WebChromeClient());
        webView.setWebViewClient(new FragReportBoard .WebViewClientClass());
        webView.loadUrl("http://175.211.48.98:8088/BoardCa/App_list.do?list=4&id="+ id+"&nickname="+nickname);

        return viewGroup;

    }

    private class WebViewClientClass extends WebViewClient {

        @Override
        public boolean shouldOverrideUrlLoading(WebView view, String url) {
            Log.d("check URL", url);
            view.loadUrl(url);
            return true;
        }
    }
}
