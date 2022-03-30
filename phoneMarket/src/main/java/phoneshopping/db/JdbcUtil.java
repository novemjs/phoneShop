package phoneshopping.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class JdbcUtil {
	
	public static Connection getConnection() {
		Connection con=null;
		
		try {
			Context initCtx=new InitialContext();
			Context envCtx=(Context)initCtx.lookup("java:comp/env");
			//mysql 데이터베이스 연결 정보를 선언한다.
			DataSource ds=(DataSource)envCtx.lookup("jdbc/MySQLDB");
			//데이터베이스 연결
			con=ds.getConnection();
			//자동 커밋 안함
			con.setAutoCommit(false);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return con;
	}
	
	public static void close(Connection con) {
		try {
			con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void close(PreparedStatement pstmt) {
		try {
			pstmt.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void close(ResultSet rs) {
		try {
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void commit(Connection con) {
		try {
			con.commit();
			System.out.println("commit success");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void rollback(Connection con) {
		try {
			con.rollback();
			System.out.println("rollback success");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}