package com.newlecture.webapp.dao.spring;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import com.newlecture.webapp.dao.NoticeDao;
import com.newlecture.webapp.entity.Notice;
import com.newlecture.webapp.entity.NoticeView;

public class SpringNoticeDao implements NoticeDao {
	
	@Autowired
	private JdbcTemplate template;
	
	/*처리방법1
	 * @Autowired
	private PlatformTransactionManager transactionManager;*/
	
	/*@Autowired
	private TransactionTemplate transactiontemplate;*/
	
	public NoticeView get(String id) {
		
		String sql = "SELECT * FROM Notice WHERE id = ?";
		NoticeView notice = template.queryForObject(sql,
				new Object[] {id},
				BeanPropertyRowMapper.newInstance(NoticeView.class)); //반환값이 리스트일경우 queryForObject이 아닌 query로 작성.
		
		/*
		 * 
	@Autowired
	private DataSource dataSource;
	String sql = "SELECT * FROM Notice WHERE id = ?";
		NoticeView notice = template.queryForObject(sql,
				new Object[] {id},
				new RowMapper<NoticeView>() {

					@Override
					public NoticeView mapRow(ResultSet rs, int rowNum) throws SQLException {
						
						NoticeView notice = new NoticeView();
						notice.setId(rs.getString("id"));
						notice.setTitle(rs.getString("title")+"메렁");
						notice.setWriterId(rs.getString("writerId"));
						notice.setContent(rs.getString("content"));
						notice.setHit(0);
						
						return null;
					}
			
		}
		);*/

		/*DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName("com.mysql.jdbc.Driver");
		dataSource.setUrl("jdbc:mysql://211.238.142.247/newlecture?autoReconnect=true&useSSL=false&useUnicode=true&characterEncoding=utf8");
		dataSource.setUsername("sist");
		dataSource.setPassword("cclass");
		
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		jdbcTemplate.setDataSource(dataSource);
		NoticeView notice = template.queryForObject(sql,
				BeanPropertyRowMapper.newInstance(NoticeView.class)); //반환값이 리스트일경우 queryForObject이 아닌 query로 작성.*/
		return notice;
	}

	public int update(String id, String title, String content) {
		String sql = "UPDATE Notice SET title = ?, content = ? WHERE id = ?";
		int result = template.update(sql,title,content,id);
		return result;
	}
	

	public int getCount() {
		String sql = "select count(id) from Notice";
		
		int count = template.queryForObject(sql, Integer.class);
		
		return count;
	}


	@Override
	public List<NoticeView> getList(int page, String field, String query) {
		String sql = "SELECT * FROM NoticeView where "+field+" like ? order by regDate desc limit ?, 10";
		
		List<NoticeView> list = template.query(sql, new Object[] {"%"+query+"%", (page-1)*10}, BeanPropertyRowMapper.newInstance(NoticeView.class));
		return list;
	}

	@Override
	public NoticeView getPrev(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public NoticeView getNext(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insert(String title, String content, String writerId) {
		// TODO Auto-generated method stub
		return insert(new Notice(title,content,writerId));
	}
	
	//트랜잭션 처리방법3,4
	//AOP를 사용하는법
	 @Override
		public int insert(Notice notice) {
			String sql = "insert into Notice(id, title, content, writerId) value(?,?,?,?)";
			String sqll = "update Member set point=point+1 where id = ?";
			
			int result=0;
			
					result += template.update(sql,getNextId(),notice.getTitle(),notice.getContent(),notice.getWriterId());
					
					result += template.update(sqll,notice.getWriterId());
			
			return result;
		}
	
	/* 트랜잭션 처리방법2
	 * @Override
	public int insert(Notice notice) {
		String sql = "insert into Notice(id, title, content, writerId) value(?,?,?,?)";
		String sqll = "update Member set point=point+1 where id = ?";
		int result = 0;
		
		result = (int)transactiontemplate.execute(new TransactionCallbackWithoutResult() {
			
			@Override
			protected void doInTransactionWithoutResult(TransactionStatus arg0) {
				template.update(sql,getNextId(),notice.getTitle(),notice.getContent(),notice.getWriterId());
				
				template.update(sqll,notice.getWriterId());
				
			}
		});
		return result;
	}*/


	/* 트랜잭션 매니저 직접 사용하는법. 1번
	 * @Override
	public int insert(Notice notice) {
		String sql = "insert into Notice(id, title, content, writerId) value(?,?,?,?)";
		String sqll = "update Member set point=point+1 where id = ?";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus state = 
				transactionManager.getTransaction(def);
		
		try {
		int result = template.update(sql,getNextId(),notice.getTitle(),notice.getContent(),notice.getWriterId());
		
		result += template.update(sqll,notice.getWriterId());
		
		transactionManager.commit(state);
		
		return result;
		}
		catch(Exception e) {
			transactionManager.rollback(state);
			
			throw e;
		}
	}
*/
	@Override
	public String getNextId() {
		String sql = "select IFNULL(max(cast(id as unsigned)), 0)+1 from Notice";
		String result = template.queryForObject(sql, String.class);
		return result;
	}
}