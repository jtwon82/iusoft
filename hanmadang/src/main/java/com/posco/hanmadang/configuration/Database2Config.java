package com.posco.hanmadang.configuration;

import java.io.IOException;
import java.net.URISyntaxException;
import java.security.GeneralSecurityException;
import java.text.ParseException;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
 
@Configuration
@MapperScan(value="com.posco.hanmadang.mapper.scms", sqlSessionFactoryRef="db2SqlSessionFactory")
@EnableTransactionManagement
public class Database2Config {
 
    @Bean(name = "db2DataSource")
    @ConfigurationProperties(prefix = "spring.db2.datasource")
    public DataSource db1DataSource() {
        return DataSourceBuilder.create().build();
    }
 
    @Bean(name = "db2SqlSessionFactory")
    public SqlSessionFactory db1SqlSessionFactory(@Qualifier("db2DataSource") DataSource db1DataSource, ApplicationContext applicationContext) throws Exception {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(db1DataSource);
        sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:mybatis/mapper/scms/*.xml"));
        sqlSessionFactoryBean.setTypeAliasesPackage("com.posco.hanmadang.model");
        return sqlSessionFactoryBean.getObject();
    }
 
    @Bean(name = "db2SqlSessionTemplate")
    public SqlSessionTemplate db1SqlSessionTemplate(SqlSessionFactory db1SqlSessionFactory) throws Exception {
 
        return new SqlSessionTemplate(db1SqlSessionFactory);
    }
    
    @Bean
    public PlatformTransactionManager transactionManager() throws URISyntaxException, GeneralSecurityException, ParseException, IOException {
        return new DataSourceTransactionManager(db1DataSource());
    }
}