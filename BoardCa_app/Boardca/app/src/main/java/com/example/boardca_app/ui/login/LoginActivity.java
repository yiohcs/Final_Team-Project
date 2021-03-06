package com.example.boardca_app.ui.login;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Base64;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.annotation.StringRes;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;

import com.example.boardca_app.MainActivity;
import com.example.boardca_app.R;
import com.example.boardca_app.data.PreferenceManager;
import com.example.boardca_app.ui.community.MakeActivity;
import com.example.boardca_app.ui.home.HomeFragment;
import com.example.boardca_app.ui.signup.SignUpActivity;
import com.example.boardca_app.ui.signup.TermsActivity;
import com.kakao.auth.ApiErrorCode;
import com.kakao.auth.ApprovalType;
import com.kakao.auth.AuthType;
import com.kakao.auth.IApplicationConfig;
import com.kakao.auth.ISessionCallback;
import com.kakao.auth.ISessionConfig;
import com.kakao.auth.KakaoAdapter;
import com.kakao.auth.KakaoSDK;
import com.kakao.auth.Session;
import com.kakao.network.ErrorResult;
import com.kakao.usermgmt.UserManagement;
import com.kakao.usermgmt.callback.LogoutResponseCallback;
import com.kakao.usermgmt.callback.MeV2ResponseCallback;
import com.kakao.usermgmt.response.MeV2Response;
import com.kakao.usermgmt.response.model.AgeRange;
import com.kakao.usermgmt.response.model.Gender;
import com.kakao.usermgmt.response.model.UserAccount;
import com.kakao.util.OptionalBoolean;
import com.kakao.util.exception.KakaoException;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.MessageDigest;

public class LoginActivity extends AppCompatActivity {

    private LoginViewModel loginViewModel;
    private Context mContext;
    private SessionCallback sessionCallback;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        mContext = this; //??????!

        loginViewModel = ViewModelProviders.of(this, new LoginViewModelFactory())
                .get(LoginViewModel.class);

        final EditText usernameEditText = findViewById(R.id.et_username);
        final EditText passwordEditText = findViewById(R.id.et_password);
        final Button loginButton = findViewById(R.id.login);
        final ProgressBar loadingProgressBar = findViewById(R.id.loading);
        final CheckBox cb_save = (CheckBox) findViewById(R.id.cb_save);
        final CheckBox auto_save = (CheckBox) findViewById(R.id.auto_save);

        sessionCallback = new SessionCallback();
        Session.getCurrentSession().addCallback(sessionCallback);
        Session.getCurrentSession().checkAndImplicitOpen();
        sessionCallback.getAppKeyHash();

        //???????????????
//        SharedPreferences auto = getSharedPreferences("auto", Activity.MODE_PRIVATE); //???????????????
//        String loginId = auto.getString("inputId", null);
//        String loginPwd = auto.getString("inputPwd", null);

        //ID?????? ????????????.
        usernameEditText.setOnKeyListener(new View.OnKeyListener() {
            @Override
            public boolean onKey(View v, int keyCode, KeyEvent event) {
                // TODO Auto-generated method stub
                if (event.getAction() == KeyEvent.ACTION_DOWN) {
                    if (keyCode == event.KEYCODE_ENTER) {
                        return true;
                    }
                }
                return false;
            }
        });

        //???????????? ??????
        TextView txt = (TextView) findViewById(R.id.signup_next_text);
        txt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getApplicationContext(), TermsActivity.class);
                //intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK); //????????? ???????????? ???????????????.
                startActivity(intent);
                overridePendingTransition(0, 0);
                finish();
            }
        });


        //????????? ?????? ??????
        boolean boo = PreferenceManager.getBoolean(mContext, "check");
        if (boo) {
            //????????? ??????????????? ??????????????? ?????? ??????
            usernameEditText.setText(PreferenceManager.getString(mContext, "username"));
            passwordEditText.setText(PreferenceManager.getString(mContext, "password"));
            cb_save.setChecked(true); //??????????????? ????????????
        }

        // ?????? ????????? ??????
        boolean boo1 = PreferenceManager.getBoolean(mContext, "auto");
        if (boo1) {
            //????????? ??????????????? ??????????????? ?????? ??????
            usernameEditText.setText(PreferenceManager.getString(mContext, "username"));
            passwordEditText.setText(PreferenceManager.getString(mContext, "password"));
            auto_save.setChecked(true); //??????????????? ????????????
        }

        //????????? ????????? ???????????? ????????? ????????? ??????.
        loginButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                PreferenceManager.setString(mContext, "username", usernameEditText.getText().toString());
                PreferenceManager.setString(mContext, "password", passwordEditText.getText().toString());

                String checkID = PreferenceManager.getString(mContext, "username");
                String checkPW = PreferenceManager.getString(mContext, "password");
            }
        });

        //????????? ??????-???????????? ?????? ????????? ?????? ?????? ??????.
        cb_save.setOnClickListener(new CheckBox.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (((CheckBox) view).isChecked()) { //??????????????? ????????? ???????????????,
                    PreferenceManager.setString(mContext, "username", usernameEditText.getText().toString());
                    PreferenceManager.setString(mContext, "password", passwordEditText.getText().toString());
                    PreferenceManager.setBoolean(mContext, "check", cb_save.isChecked());
                } else { //??????????????? ?????? ???????????????.
                    PreferenceManager.setBoolean(mContext, "check", cb_save.isChecked());
                    PreferenceManager.clear(mContext);
                }
            }
        });
        //?????? ????????? - ???????????? ?????? ????????? ?????? ?????? ??????.
        auto_save.setOnClickListener(new CheckBox.OnClickListener() {
            @Override
            public void onClick(View view) {
//                SharedPreferences auto = getSharedPreferences("auto", Activity.MODE_PRIVATE);
//                SharedPreferences.Editor autoLogin = auto.edit();
//                autoLogin.putString("inputUsername", usernameEditText.getText().toString());
//                autoLogin.putString("inputPwd", passwordEditText.getText().toString());
//
//                autoLogin.commit();

                if (((CheckBox) view).isChecked()) { //??????????????? ????????? ???????????????,
                    PreferenceManager.setString(mContext, "username", usernameEditText.getText().toString());
                    PreferenceManager.setString(mContext, "password", passwordEditText.getText().toString());
                    PreferenceManager.setBoolean(mContext, "auto", auto_save.isChecked());
                } else { //??????????????? ?????? ???????????????.
                    PreferenceManager.setBoolean(mContext, "auto", auto_save.isChecked());
                    PreferenceManager.clear(mContext);
                }

            }
        });


        loginViewModel.getLoginFormState().observe(this, new Observer<LoginFormState>() {
            @Override
            public void onChanged(@Nullable LoginFormState loginFormState) {
                if (loginFormState == null) {
                    return;
                }
                loginButton.setEnabled(loginFormState.isDataValid());
                if (loginFormState.getUsernameError() != null) {
                    usernameEditText.setError(getString(loginFormState.getUsernameError()));
                }
                if (loginFormState.getPasswordError() != null) {
                    passwordEditText.setError(getString(loginFormState.getPasswordError()));
                }
            }
        });

        loginViewModel.getLoginResult().observe(this, new Observer<LoginResult>() {
            @Override
            public void onChanged(@Nullable LoginResult loginResult) {
                if (loginResult == null) {
                    return;
                }
                loadingProgressBar.setVisibility(View.GONE);
                if (loginResult.getError() != null) {
                    showLoginFailed(loginResult.getError());
                }
                if (loginResult.getSuccess() != null) {
                    updateUiWithUser(loginResult.getSuccess());
                }
                setResult(Activity.RESULT_OK);

                Intent intent = new Intent(getApplicationContext(), MainActivity.class);
                startActivity(intent);
                overridePendingTransition(0, 0);

                //Complete and destroy login activity once successful
                finish();
            }
        });

        TextWatcher afterTextChangedListener = new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                // ignore
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                // ignore
            }

            @Override
            public void afterTextChanged(Editable s) {
                loginViewModel.loginDataChanged(usernameEditText.getText().toString(),
                        passwordEditText.getText().toString());
            }
        };
        usernameEditText.addTextChangedListener(afterTextChangedListener);
        passwordEditText.addTextChangedListener(afterTextChangedListener);
        passwordEditText.setOnEditorActionListener(new TextView.OnEditorActionListener() {

            @Override
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                if (actionId == EditorInfo.IME_ACTION_DONE) {
                    loginViewModel.login(usernameEditText.getText().toString(),
                            passwordEditText.getText().toString());
                }
                return false;
            }
        });

        loginButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String id = "";
                String pw = "";

                if (usernameEditText.getText() != null) {
                    id = usernameEditText.getText() + "";
                }
                if (passwordEditText.getText() != null) {
                    pw = passwordEditText.getText() + "";
                }

                String result = "false";
                try {
                    IdPw idpw = new IdPw();
                    result = idpw.execute(id, pw).get();
                    Log.i("?????? ???", result);
                } catch (Exception e) {

                }

                if (result.equals("true")) {
                    String nickname = "";
                    try {
                        Nick task = new Nick();
                        nickname = task.execute(id).get();
                        Log.i("?????? ???", nickname);
                        finish();
                    } catch (Exception e) {
                    }

                    Toast.makeText(LoginActivity.this, id + "???! ????????? ??????!", Toast.LENGTH_SHORT).show();
                    Intent intent = new Intent(getApplicationContext(), MainActivity.class);
                    intent.putExtra("id", usernameEditText.getText() + "");
                    intent.putExtra("nickname", nickname);

                    //intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK); //????????? ???????????? ???????????????.
                    startActivity(intent);
                    overridePendingTransition(0, 0);
                    finish();
                } else {
                    Toast.makeText(LoginActivity.this, "????????? ??????! ???????????? ????????? ??????????????????.", Toast.LENGTH_SHORT).show();
                }
//                loadingProgressBar.setVisibility(View.VISIBLE);
//                loginViewModel.login(usernameEditText.getText().toString(),
//                        passwordEditText.getText().toString());
            }
        });


        if (auto_save.isChecked()) {
            if (usernameEditText.getText() != null && !(usernameEditText.getText().equals(""))) {
                if (passwordEditText.getText() != null && !(passwordEditText.getText().equals(""))) {
                    loginButton.callOnClick();
                }
            }
        }
    }

    private void updateUiWithUser(LoggedInUserView model) {
        String welcome = getString(R.string.welcome) + model.getDisplayName();
        // TODO : initiate successful logged in experience
        Toast.makeText(getApplicationContext(), welcome, Toast.LENGTH_LONG).show();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Session.getCurrentSession().removeCallback(sessionCallback);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (Session.getCurrentSession().handleActivityResult(requestCode, resultCode, data)) {
            super.onActivityResult(requestCode, resultCode, data);
            return;
        }
    }

    private void showLoginFailed(@StringRes Integer errorString) {
        Toast.makeText(getApplicationContext(), errorString, Toast.LENGTH_SHORT).show();
    }


    //kakao
    private class SessionCallback implements ISessionCallback {

        @Override
        public void onSessionOpened() {
            //????????? ????????? ????????? ???.
            UserManagement.getInstance().me(new MeV2ResponseCallback() {
                @Override
                public void onFailure(ErrorResult errorResult) {
                    int result = errorResult.getErrorCode();

                    if (result == ApiErrorCode.CLIENT_ERROR_CODE) {
                        Toast.makeText(getApplicationContext(), "???????????? ????????? ??????????????????. ?????? ????????? ?????????.", Toast.LENGTH_SHORT).show();
                        finish();
                    } else {
                        Toast.makeText(getApplicationContext(), "????????? ?????? ????????? ??????????????????: " + errorResult.getErrorMessage(), Toast.LENGTH_SHORT).show();
                    }
                }

                @Override
                public void onSessionClosed(ErrorResult errorResult) {
                    Toast.makeText(getApplicationContext(), "????????? ???????????????. ?????? ????????? ?????????: " + errorResult.getErrorMessage(), Toast.LENGTH_SHORT).show();
                }

                @Override
                public void onSuccess(MeV2Response result) {

                    String MEM_NICKNAME;
                    if (result.getNickname() != null) {
                        MEM_NICKNAME = result.getNickname();
                    } else {
                        MEM_NICKNAME = "";
                    }

                    String MEM_EMAIL;
                    if (result.getKakaoAccount().getEmail() != null) {
                        MEM_EMAIL = result.getKakaoAccount().getEmail();
                    } else {
                        MEM_EMAIL = "";
                    }

                    AgeRange ageRange;
                    String MEM_AGE_GROUP;
                    if (result.getKakaoAccount().getAgeRange() != null) {
                        ageRange = result.getKakaoAccount().getAgeRange();

                        switch (ageRange) {
                            case AGE_20_29:
                                MEM_AGE_GROUP = "20???";
                                break;
                            case AGE_30_39:
                                MEM_AGE_GROUP = "30???";
                                break;
                            case AGE_40_49:
                                MEM_AGE_GROUP = "40???";
                                break;
                            case AGE_50_59:
                            case AGE_60_69:
                            case AGE_70_79:
                            case AGE_80_89:
                            case AGE_90_ABOVE:
                                MEM_AGE_GROUP = "50??? ??????";
                                break;
                            case AGE_RANGE_UNKNOWN:
                                MEM_AGE_GROUP = "?????????";
                                break;
                            default:
                                MEM_AGE_GROUP = "????????? 19?????????!!!";
                        }
                    } else {
                        MEM_AGE_GROUP = "";
                    }


                    String gender;
                    String MEM_GENDER;
                    if (result.getKakaoAccount().getGender() != null) {
                        gender = result.getKakaoAccount().getGender() + "";
                        if (gender.equals("MALE")) {
                            MEM_GENDER = "??????";
                        } else if (gender.equals("FEMALE")) {
                            MEM_GENDER = "??????";
                        } else {
                            MEM_GENDER = "?????????";
                        }
                    } else {
                        MEM_GENDER = "";
                    }

//                    UserAccount account =  result.getKakaoAccount();
//
//                    System.out.println(account);

                    long id2 = result.getId();

                    String MEM_ID = id2 + "";


                    Log.e("nickname : ", MEM_NICKNAME + "");
                    Log.e("email : ", MEM_EMAIL + "");
                    Log.e("id : ", MEM_ID + "");
                    Log.e("age : ", MEM_AGE_GROUP + "");
                    Log.e("mf : ", MEM_GENDER + "");


                    if (!(MEM_NICKNAME.equals(""))) {
                        // ????????? ???????????? ?????? ??????, ????????? ??????

                        Intent intent = new Intent(getApplicationContext(), MainActivity.class);
                        intent.putExtra("nickname", MEM_NICKNAME);
                        intent.putExtra("email", MEM_EMAIL);
                        intent.putExtra("id", MEM_ID);
                        intent.putExtra("age", MEM_AGE_GROUP);
                        intent.putExtra("mf", MEM_GENDER);

                        startActivity(intent);
                        overridePendingTransition(0, 0);

                        try {
                            String str;
                            LoginActivity.CustomTask task = new LoginActivity.CustomTask();
                            str = task.execute(MEM_NICKNAME, MEM_EMAIL, MEM_ID, MEM_AGE_GROUP, MEM_GENDER).get();
                            Log.i("?????? ???", str);
                            finish();
                        } catch (Exception e) {

                        }

                    } else {
                        // ????????? ???????????? ?????????, ????????? ???????????? ?????? ??????
                        String str = "";
                        try {
                            LoginActivity.CustomTask task = new LoginActivity.CustomTask();
                            str = task.execute(MEM_ID).get();
                            Log.i("?????? ???", str);
                            finish();
                        } catch (Exception e) {

                        }
                        if (str.equals("")) {

                            // ????????? ???????????? ?????? ??????, ???????????? ???????????? ??????

                            Intent intent = new Intent(getApplicationContext(), SignUpActivity.class);
                            intent.putExtra("nickname", MEM_NICKNAME);
                            intent.putExtra("email", MEM_EMAIL);
                            intent.putExtra("id", MEM_ID);
                            intent.putExtra("age", MEM_AGE_GROUP);
                            intent.putExtra("mf", MEM_GENDER);

                            startActivity(intent);
                            overridePendingTransition(0, 0);

                            try {
                                LoginActivity.Nick nick = new LoginActivity.Nick();
                                str = nick.execute(MEM_ID).get();
                                Log.i("?????? ???", str);
                                finish();
                            } catch (Exception e) {

                            }
                        } else {
                            Intent intent = new Intent(getApplicationContext(), MainActivity.class);
                            intent.putExtra("nickname", MEM_NICKNAME);
                            intent.putExtra("email", MEM_EMAIL);
                            intent.putExtra("id", MEM_ID);
                            intent.putExtra("age", MEM_AGE_GROUP);
                            intent.putExtra("mf", MEM_GENDER);

                            startActivity(intent);
                            overridePendingTransition(0, 0);
                        }
                    }
                }

            });
        }

        @Override
        public void onSessionOpenFailed(KakaoException exception) {
            //????????? ????????? ??????????????? ????????? ????????? ???.
            Toast.makeText(getApplicationContext(), "????????? ?????? ????????? ??????????????????. ????????? ????????? ??????????????????: " + exception.toString(), Toast.LENGTH_SHORT).show();
        }

        private void getAppKeyHash() {
            try {
                PackageInfo info = getPackageManager().getPackageInfo(getPackageName(), PackageManager.GET_SIGNATURES);
                for (Signature signature : info.signatures) {
                    MessageDigest md;
                    md = MessageDigest.getInstance("SHA");
                    md.update(signature.toByteArray());
                    String something = new String(Base64.encode(md.digest(), 0));
                    Log.e("Hash key", something);
                }
            } catch (Exception e) {
                // TODO Auto-generated catch block
                Log.e("name not found", e.toString());
            }
        }

        public void onFailure(ErrorResult errorResult) {
            int result = errorResult.getErrorCode();

            if (result == ApiErrorCode.CLIENT_ERROR_CODE) {
                Toast.makeText(getApplicationContext(), "???????????? ????????? ??????????????????. ?????? ????????? ?????????.", Toast.LENGTH_SHORT).show();
                finish();
            } else {
                Toast.makeText(getApplicationContext(), "????????? ?????? ????????? ??????????????????: " + errorResult.getErrorMessage(), Toast.LENGTH_SHORT).show();
            }
        }

    }

    // ????????? ?????????
    class CustomTask extends AsyncTask<String, Void, String> {
        String sendMsg, receiveMsg;

        // JSP??? ?????? ?????? ???, MySQL??? ????????? ??????
        @Override
        protected String doInBackground(String... strings) {
            try {
                String str;
                URL url = new URL("http://182.213.18.164:8088/BoardCa/app_input.do");
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
                conn.setRequestMethod("POST");
                OutputStreamWriter osw = new OutputStreamWriter(conn.getOutputStream());
                sendMsg = "nickname=" + strings[0] + "&email=" + strings[1] + "&id=" + strings[2] + "&age=" + strings[3] + "&mf=" + strings[4];
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
                    Log.i("?????? ??????", conn.getResponseCode() + "??????");
                }
                osw.close();
            } catch (MalformedURLException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return receiveMsg;
        }
    }

    // id pw ??????
    class IdPw extends AsyncTask<String, Void, String> {
        String sendMsg, receiveMsg;

        // JSP??? ?????? ?????? ???, MySQL??? ????????? ??????
        @Override
        protected String doInBackground(String... strings) {
            try {
                String str;
                URL url = new URL("http://182.213.18.164:8088/BoardCa/app_idpw.do");
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
                conn.setRequestMethod("POST");
                OutputStreamWriter osw = new OutputStreamWriter(conn.getOutputStream());
                sendMsg = "id=" + strings[0] + "&pw=" + strings[1];

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
                    Log.i("?????? ??????", conn.getResponseCode() + "??????");
                }
                osw.close();
            } catch (MalformedURLException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return receiveMsg;
        }
    }


    // nick ??????
    class Nick extends AsyncTask<String, Void, String> {
        String sendMsg, receiveMsg;

        // JSP??? ?????? ?????? ???, MySQL??? ????????? ??????
        @Override
        protected String doInBackground(String... strings) {
            try {
                String str;
                URL url = new URL("http://182.213.18.164:8088/BoardCa/app_nick.do");
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
                conn.setRequestMethod("POST");
                OutputStreamWriter osw = new OutputStreamWriter(conn.getOutputStream());
                sendMsg = "id=" + strings[0];

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
                    Log.i("?????? ??????", conn.getResponseCode() + "??????");
                }
                osw.close();
            } catch (MalformedURLException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return receiveMsg;
        }
    }
}