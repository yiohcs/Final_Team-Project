package com.example.boardca_app.ui.community;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.airbnb.lottie.L;
import com.esafirm.imagepicker.features.ImagePicker;
import com.esafirm.imagepicker.model.Image;
import com.example.boardca_app.R;
import com.lumyjuwon.richwysiwygeditor.RichWysiwyg;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

public class MakeActivity extends AppCompatActivity {

    private RichWysiwyg wysiwyg;
    private RadioGroup rg;
    private RadioButton rb;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_make);
        wysiwyg = findViewById(R.id.richwysiwygeditor);

        rg = (RadioGroup) findViewById(R.id.rg1);

        wysiwyg.getContent()
                .setEditorFontSize(18)
                .setEditorPadding(4, 0, 4, 0);

        wysiwyg.getHeadlineEditText().setHint("Title");

        wysiwyg.getCancelButton().setText("Cancel");
        wysiwyg.getCancelButton().setOnClickListener(new Button.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        wysiwyg.getConfirmButton().setText("Write");
        wysiwyg.getConfirmButton().setOnClickListener(new Button.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Handle this
                Log.i("Rich Wysiwyg Headline", wysiwyg.getHeadlineEditText().getText().toString());
                if (wysiwyg.getContent().getHtml() != null)
                    Log.i("Rich Wysiwyg", wysiwyg.getContent().getHtml());

                rb = (RadioButton) findViewById(rg.getCheckedRadioButtonId());

                boolean tf = false;
                String title = "";
                String text = "";
                String community = "";

                if (rb == null) {
                    showText(0);
                } else {
                    if (wysiwyg.getHeadlineEditText().getText().toString().equals("")) {
                        showText(1);
                    } else {
                        if (wysiwyg.getContent().getHtml() == null) {
                            showText(2);
                        } else {
                            tf = true;
                        }
                    }
                }

                if (tf) {
                    community = rb.getText().toString();
                    title = wysiwyg.getHeadlineEditText().getText().toString();
                    text = wysiwyg.getContent().getHtml();
                    try {
                        String result;
                        CustomTask task = new CustomTask();
                        result = task.execute(title, text, community).get();
                        Log.i("리턴 값", result);
                        finish();
                    } catch (Exception e) {

                    }
                    tf = false;
                }
            }
        });
    }

    public void showText(int num) {
        switch (num) {
            case 0:
                Toast.makeText(this, "커뮤니티를 선택해주세요.", Toast.LENGTH_SHORT).show();
                break;
            case 1:
                Toast.makeText(this, "제목을 입력해주세요.", Toast.LENGTH_SHORT).show();
                break;
            case 2:
                Toast.makeText(this, "내용을 입력해주세요.", Toast.LENGTH_SHORT).show();
                break;
        }
    }

    @Override
    protected void onActivityResult(int requestCode, final int resultCode, Intent data) {
        if (ImagePicker.shouldHandle(requestCode, resultCode, data)) {
            List<Image> images = ImagePicker.getImages(data);
            insertImages(images);
        }
        super.onActivityResult(requestCode, resultCode, data);
    }

    private void insertImages(List<Image> images) {

        if (images == null) return;

        StringBuilder stringBuffer = new StringBuilder();
        for (int i = 0, l = images.size(); i < l; i++) {
            stringBuffer.append(images.get(i).getPath()).append("\n");
            // Handle this
            wysiwyg.getContent().insertImage("file://" + images.get(i).getPath(), "alt");
        }
    }


    class CustomTask extends AsyncTask<String, Void, String> {
        String sendMsg, receiveMsg;

        @Override
        protected String doInBackground(String... strings) {
            try {
                String str;
                URL url = new URL("http://192.168.219.112:8088/android1/home.do");
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
                conn.setRequestMethod("POST");
                OutputStreamWriter osw = new OutputStreamWriter(conn.getOutputStream());
                sendMsg = "title=" + strings[0] + "&text=" + strings[1] + "&community=" + strings[2];
                osw.write(sendMsg);
                osw.flush();
                if (conn.getResponseCode() == conn.HTTP_OK) {
                    InputStreamReader tmp = new InputStreamReader(conn.getInputStream(), "UTF-8");
                    BufferedReader reader = new BufferedReader(tmp);
                    StringBuffer buffer = new StringBuffer();
                    while ((str = reader.readLine()) != null) {
                        buffer.append(str);
                    }
                    receiveMsg = buffer.toString();

                } else {
                    Log.i("통신 결과", conn.getResponseCode() + "에러");
                }

            } catch (MalformedURLException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return receiveMsg;
        }
    }
}