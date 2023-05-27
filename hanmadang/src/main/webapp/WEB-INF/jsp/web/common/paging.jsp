<%@ page contentType = "text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import ="com.posco.hanmadang.util.Paging"%>
<%--
String.format 을 쓰고 싶었지만 검색어 (%EC 등으로 인코딩 ) 때문에 사용할 수 없어 string replace를 사용
 --%>
 
<% Paging p= (Paging)request.getAttribute("paging");
	    int pageNumber = p.getPageNumber();
	    int entryCountPerOnePage = p.getEntryCountPerOnePage();
	    int pageCountPerPageGroup = p.getPageCountPerPageGroup();
	    int totalEntryCount = p.getTotalEntryCount();
	    int curPageNavi = p.getCurPageNavi();
	    int lastPageNumber = p.getLastPageNumber();
	    int totalNaviCount = p.getTotalNaviCount(lastPageNumber);
	    int startPageNumber = p.getStartPageNumber(curPageNavi);
	    int endPageNumber = p.getEndPageNumber( startPageNumber);
	    String urlFormat = p.getBaseUrlFormat();
	%>
	
						<div class="paging">
						<% if  ( pageNumber > 1 ) { %>
						<a href="<%=urlFormat.replace("%pageNumber%", Integer.toString(pageNumber - 1) ) %>" class="paging__btn-prev">이전</a>
						 <%} else { %>
						 <a href="#" class="paging__btn-prev">이전</a>
						 <%}%>
							<a href="#none" class="paging__num is-selected"><%=pageNumber %></a>
							<span class="paging__bar">/</span>
							<a href="<%=urlFormat.replace("%pageNumber%", Integer.toString(lastPageNumber) ) %>" class="paging__num"><%=lastPageNumber %></a>
							<% if  ( pageNumber < lastPageNumber ) { %>
							<a href="<%=urlFormat.replace("%pageNumber%", Integer.toString(pageNumber + 1) ) %>" class="paging__btn-next">다음</a>
							<%} else { %>
							<a href="#" class="paging__btn-next">다음</a>
							<%}%>
						</div>