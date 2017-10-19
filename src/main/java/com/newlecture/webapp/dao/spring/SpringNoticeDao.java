package com.newlecture.webapp.dao.spring;

import java.sql.DriverManager;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.newlecture.webapp.dao.NoticeDao;
import com.newlecture.webapp.entity.Notice;
import com.newlecture.webapp.entity.NoticeView;

public class SpringNoticeDao implements NoticeDao {
	
	private JdbcTemplate template;
	
	public void setTemplate(JdbcTemplate template) {
		this.template = template;
	}

	@Autowired
	private DataSource dataSource;

	public List<NoticeView> getList(int page, String query) {
		
		return null;
	}

	public int getCount() {
		return 0;
	}

	public NoticeView get(String id) {
		
		String sql = "SELECT * FROM Notice WHERE id = ?";
		NoticeView notice = template.queryForObject(sql,
				new Object[] {id},
				BeanPropertyRowMapper.newInstance(NoticeView.class)); //반환값이 리스트일경우 queryForObject이 아닌 query로 작성.

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
		return 0;
	}

	@Override
	public List<NoticeView> getList(int page, String field, String query) {
		// TODO Auto-generated method stub
		return null;
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
		return 0;
	}

	@Override
	public int insert(Notice notice) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String getNextId() {
		// TODO Auto-generated method stub
		return null;
	}

}