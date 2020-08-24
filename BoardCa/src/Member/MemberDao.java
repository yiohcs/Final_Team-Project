package Member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDao {

	@Autowired
	private SqlSession sqlSession;
	
	public int idCheck(String userId) {		
		System.out.println("DaoIDCheck "+userId);
		int dto = sqlSession.selectOne("signXml.idCheck", userId); 
		return dto;
	}	
	
	public String signIn(String userId) {		
		System.out.println("DaoSignIn "+userId);
		return sqlSession.selectOne("signXml.signCheck",userId);
	}
	public void sessionInput() {
		sqlSession.insert("signXml.sessionInput");
	}
}