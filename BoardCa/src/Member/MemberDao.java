package Member;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import Sign.SessionDto;

@Repository
public class MemberDao {

	@Autowired
	private SqlSession mysqlSession;
	
// 입력한 아이디가 있는 아이디인지 아이디 체크 
	public int idCheck(String userId) {		
		System.out.println("DaoIDCheck "+userId);
		int dto = mysqlSession.selectOne("signXml.idCheck", userId); 
		return dto;
	}	
// 입력한 아이디가 있는 아이디인지 아이디 체크 
	public int nickNameCheck(String nickName) {		
		System.out.println("DaonickNameCheck "+nickName);
		int dto = mysqlSession.selectOne("signXml.nickNameCheck", nickName); 
		return dto;
	}	

// 로그인시 입력한 아이디와 비밀번호가 맞는지 체크 
	public String signIn(String userId) {		
		System.out.println("DaoSignIn "+userId);
		return mysqlSession.selectOne("signXml.signCheck",userId);
	}
// 입력한 아이디의 회원번호 가져오기
	public int searchIdx(String userId) {
		return mysqlSession.selectOne("signXml.searchIdx",userId);
	}
	
	
// 세션 입력 
	public void sessionInput(SessionDto sedto) {
		mysqlSession.insert("signXml.sessionInput", sedto);
	}
	
// 회원정보 insert
	public void memInsert(MemberDto dto) {
		System.out.println(dto);
		mysqlSession.insert("signXml.memInsert", dto);
	}
	
// 회원정보 전체 list
	public List<Object> ListAll() {		
		List<Object> list = mysqlSession.selectList("signXml.Listall");		
		return list;
	}
	
	
}
