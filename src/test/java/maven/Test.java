/**
 * @Description: 
 * @maven.maven
 * @FileName:Test.java
 * @Created By:景长超
 * @Created:2017年4月10日 下午11:04:46
 */
package maven;

import java.sql.DriverManager;

import com.mysql.jdbc.Connection;

/**
 * @Description
 * @ClassName Test
 * @author 景长超
 * @Created 2017 2017年4月10日 下午11:04:46
 */
public class Test {
	public static void main(String[] args) {
		try {
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection conn = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/?user=root&password=root&useUnicode=true&characterEncoding=UTF8");
		   // Statement s =  (Statement) conn.createStatement();
		    System.out.println(conn.isClosed());
		}
		 catch (Exception e) {
		            e.printStackTrace();
		}
	}

}
