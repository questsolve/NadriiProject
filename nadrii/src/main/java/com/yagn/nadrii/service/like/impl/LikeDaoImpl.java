package com.yagn.nadrii.service.like.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.yagn.nadrii.common.Search;
import com.yagn.nadrii.service.domain.Like;
import com.yagn.nadrii.service.like.LikeDao;

@Repository("likeDaoImpl")
public class LikeDaoImpl implements LikeDao{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public LikeDaoImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addLike(Like like) throws Exception {
		sqlSession.insert("LikeMapper.addLike", like);
	}
	
	public void deleteLike(Like like) throws Exception {
		sqlSession.delete("LikeMapper.deleteLike", like);
	}

	@Override
	public List<Like> getLikeList(Search search) throws Exception {
		return sqlSession.selectList("LikeMapper.getLikeList", search);
	}

	@Override
	public int getTotalLikeCount(Search search) throws Exception {
		return sqlSession.selectOne("LikeMapper.getTotalLikeCount", search);
	}
	
	@Override
	public int getLikeCount(Like like) throws Exception {
		return sqlSession.selectOne("LikeMapper.getLikeCount", like);
	}
	
}