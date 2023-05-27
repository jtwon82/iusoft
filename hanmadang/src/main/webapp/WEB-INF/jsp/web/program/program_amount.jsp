<%@ page contentType = "text/html;charset=utf-8" %>
<!doctype html>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/html">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="description" content="포스코 한마당" />
<meta name="keywords" content="포스코 한마당, 수강신청, 수강안내" />
<title>포스코 한마당</title>
<link rel="stylesheet" type="text/css" href="/web/assets/css/style.css">
<!--[if lt IE 9]>
<script src="/web/assets/js/lib/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<script src="/web/assets/js/lib/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/jquery.easing.1.3.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/jquery.nice-select.min.js" type="text/javascript"></script>
<script src="/web/assets/js/lib/sly.js" type="text/javascript"></script>
<script src="/web/assets/js/entry.js" type="text/javascript"></script>
</head>
<body>

<!-- skip -->
<%@ include file="../common/skip.jsp"%>
<!-- //skip -->
<!-- wrapper -->
<div id="wrapper">
	<!-- header -->

	<%@ include file="../common/header.jsp"%>
	<!-- //header -->
	<!-- contents -->
	<main id="contents" role="main">
		<div id="contents-inner">
			<div class="container-tabs cl-program">
				<ul>
					<li class="by-4"><a href="/program/time/all">운영시간</a></li>
					<li class="by-4 is-selected"><a href="/program/amount">분기 회원제 금액</a></li>
					<li class="by-4"><a href="/program/stadium">경기장 이용안내</a></li>
					<li class="by-4"><a href="/program/rule">이용수칙 안내</a></li>
				</ul>
			</div>
			<article class="container-notice bg-program">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>

			<article class="container">
				<div class="container-header"><h3 class="cl-program">분기(3개월) 회원제 금액</h3></div>
				<div class="table-basic-type4 line-box">
					<table>
						<caption>분기 회원제 금액에 대한 정보제공</caption>
						<colgroup>
							<col width="150px">
							<col width="230px">
							<col width="150px">
							<col width="150px">
							<col width="*">
						</colgroup>
						<thead>
							<tr>
								<th>구분</th>
								<th>종목</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;포스코 패밀리</th>
								<th>&nbsp;&nbsp;일반회원</th>
								<th>비고</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>휘트니스</td>
								<td colspan="5">
									<div class="table-basic-under4">
										<table>
											<colgroup>
												<col width="230px">
												<col width="150px">
												<col width="150px">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<td><span class="cl-program">종일반</span></td>
													<td>&nbsp;&nbsp; 60,000원</td>
													<td>150,000원</td>
													<td class="col-text"><p class="note-list">포스코 패밀리 회원 : 본인 및 배우자 - 일반회원 : 지곡동 주민</p></td>
												</tr>
												<tr>
													<td><span class="cl-program">오전반</span></td>
													<td>&nbsp;&nbsp; 30,000원</td>
													<td rowspan="2" style="text-align:center; vertical-align:middle;padding-right: 7%;">-</td>
													<td class="col-text" rowspan="2" style="vertical-align:middle;"><p class="note-list">포스코 패밀리 직원 본인만 이용 가능.</p></td>
												</tr>
												<tr>
													<td><span class="cl-program">오후반</span></td>
													<td>&nbsp;&nbsp; 30,000원</td>
												</tr>
												<tr>
													<td><span class="cl-program">일일입장제</span></td>
													<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2,000원</td>
													<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5,000원</td>
													<td class="col-text"><p class="note-list">한마당체육관 휘트니스 일일입장제 이용규정 참고</p></td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td>GX 프로그램</td>
								<td colspan="5">
									<div class="table-basic-under4">
										<table>
											<colgroup>
												<col width="230px">
												<col width="150px">
												<col width="150px">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<td><span class="cl-program">에어로빅</span></td>
													<td>&nbsp;&nbsp; 60,000원</td>
													<td>150,000원</td>
													<td class="col-text" rowspan="6">
														<p class="note-list">책정 기준 : 월 · 수 · 금 반 (주 3회)</p>
														<p class="note-list">화 · 목 반 (주 2회)<br>
														포스코 패밀리 회원  : 48,000 원<br>
														일반회원 : 120,000 원</p>
														<p class="note-list">다이어트 발레<br>
														성인 취미 발레 (20세 이상 이용 가능)</p>
													</td>
												</tr>
												<tr>
													<td><span class="cl-program">요가</span></td>
													<td>&nbsp;&nbsp; 60,000원</td>
													<td>150,000원</td>
												</tr>
												<tr>
													<td><span class="cl-program">벨리댄스</span></td>
													<td>&nbsp;&nbsp; 60,000원</td>
													<td>150,000원</td>
												</tr>
												<tr>
													<td><span class="cl-program">다이어트 댄스</span></td>
													<td>&nbsp;&nbsp; 60,000원</td>
													<td>150,000원</td>
												</tr>
												<tr>
													<td><span class="cl-program">스피닝</span></td>
													<td>&nbsp;&nbsp; 60,000원</td>
													<td>150,000원</td>
												</tr>
												<tr>
													<td><span class="cl-program">다이어트 발레</span></td>
													<td>&nbsp;&nbsp; 48,000원</td>
													<td>120,000원</td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td>스쿼시</td>
								<td><span class="cl-program">스쿼시</span></td>
								<td>105,000원</td>
								<td>210,000원</td>
								<td class="col-text"><p class="note-list">1일 입장 : 1인 3,000원(2시간)</p></td>
							</tr>
<!-- 							<tr> -->
<!-- 								<td>스크린승마</td> -->
<!-- 								<td><span class="cl-program">스크린승마</span></td> -->
<!-- 								<td>120,000원</td> -->
<!-- 								<td>270,000원</td> -->
<!-- 								<td class="col-text"><p class="note-list">1일 입장 : 1인 5,000원(50분)</p></td> -->
<!-- 							</tr> -->
							<tr>
								<td>패키지 프로그램</td>
								<td colspan="5">
									<div class="table-basic-under4">
										<table>
											<colgroup>
												<col width="230px">
												<col width="150px">
												<col width="150px">
												<col width="*">
											</colgroup>
											<tbody>
<!-- 												<tr> -->
<!-- 													<td><span class="cl-program">휘트니스(종일반) + 스크린 승마</span></td> -->
<!-- 													<td>162,000원</td> -->
<!-- 													<td>354,000원</td> -->
<!-- 													<td class="col-text" rowspan="2"><p class="note-list">10% 할인 적용</p></td> -->
<!-- 												</tr> -->
												<tr>
													<td><span class="cl-program">휘트니스(종일반) + 스쿼시</span></td>
													<td>150,000원</td>
													<td>330,000원</td>
													<td class="col-text" rowspan="2"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td>일일 프로그램</td>
								<td colspan="5">
									<div class="table-basic-under4">
										<table>
											<colgroup>
												<col width="230px">
												<col width="300px">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<td><span class="cl-program">당구 / 탁구</span></td>
													<td>1시간 3,000원(500원 / 10분)</td>
													<td class="col-text"><p class="note-list" style="word-break : nowrap;display : inline-block; text-overflow : clip; overflow : hidden; white-space : nowrap">후불 / 월~금요일(09:00~22:30) 주말(공휴일) (09:00~21:30)</p></td>
												</tr>
												<tr>
													<td><span class="cl-program">배드민턴</span></td>
													<td>1시간 2,000원(코트당)</td>
													<td class="col-text"><p class="note-list">선불 / 월~금요일(07:00~22:30) 주말(공휴일) (07:00~21:30)</p></td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							<tr>
								<td>구기종목</td>
								<td><span class="cl-program">농구 / 배구 / 족구</span></td>
								<td colspan="2">1시간 10,000원(코트당)</td>
								<td class="col-text"><p class="note-list">구기종목의 날<br>
								수요일(18:30 ~ 22:30)<br>
								일요일(07:00 ~ 11:00)</p></td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="container-header"><h3 class="cl-program">신규 가입 시 준비서류</h3></div>
				<div class="table-basic-type4 line-box">
					<table>
						<caption>신규 가입 시 준비서류에 대한 정보제공</caption>
						<colgroup>
							<col width="230px">
							<col width="370px">
							<col width="*">
						</colgroup>
						<thead>
							<tr>
								<th>구분</th>
								<th>대상</th>
								<th>준비서류</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="vertical-align: middle;">포스코 패밀리</td>
								<td style="vertical-align: middle;">포스코 직원 및 가족, 포스코 OB, 패밀리사 직원 및 가족</td>
								<td class="col-text">직원 : 사원증 또는 재직증명서<br>
										포스코 OB : 경력증명서 발급<br>
										직원가족 : 직원사원증, 본인신분증, 가족관계증명서 등<br>
										<div style="margin: 14px 0 0 0;">* 포스코 출입카드는 사원증으로 인정되지 않습니다</div>
							</tr>
							<tr>
								<td>일반회원</td>
								<td>지곡동 주민</td>
								<td class="col-text">신분증 또는 주민등록등본 사본</td>
							</tr>
						</tbody>
						
						<tbody style="display:none;">
							<tr>
								<td rowspan="1">포스코 패밀리</td>
								<td rowspan="1">포스코 직원 및 가족</td>
								<td class="col-text">직원 : 사원증 / 직원가족 : 사원증 사본, 본인신분증 사본, 가족관계증명서 등  </td>
							</tr>
<!-- 							<tr> -->
<!-- 								<td class="col-text">공통 : 개인정보 수집.이용에 관한 동의서</td> -->
<!-- 							</tr> -->
							<tr>
								<td rowspan="1">포스코 패밀리</td>
								<td rowspan="1">포스코 OB / 패밀리사 직원 및 가족</td>
								<td class="col-text">직원 : 사원증 (사원증 없을 시 재직증명서 발급) / 직원가족 : 사원증 사본, 본인신분증 사본, 가족관계증명서 등<br>
									※포스코 출입카드는 사원증으로 인정되지 않습니다.</td>
							</tr>
<!-- 							<tr> -->
<!-- 								<td class="col-text">공통 : 홈페이지 이용약관</td> -->
<!-- 							</tr> -->
						</tbody>
					</table>
				</div>

				<div class="info-inner bg-program">
					<p class="note-list">가족 : 직계가족 및 배우자 부모 포함</p>
				</div>

				<div class="container-header"><h3 class="cl-program">홈페이지(온라인) 접수 및 등록 방법</h3></div>
				<div class="info-inner-part bg-program">
					<ul class="li-list">
						<li>수강신청 : 매년 3, 6, 9, 12월</li>
						<li>수강신청 응모기간 : 매 분기 18 ~ 21일 (4일간)</li>
						<li>추첨 및 공지 : 매 분기 22일 오전 11:00</li>
					</ul>
				</div>
				<div class="program-online">
					<ul>
						<li>01. 홈페이지에서 강습 프로그램 신청(신규 / 재등록)</li>
						<li>02. 온라인 추첨</li>
						<li>03. 당첨자 중 재등록자는 온라인 결제 가능 / 신규는 안내데스크에서 가입 시 준비서류 확인 후 등록 및 결제</li>
					</ul>
				</div>

			</article>
		</div>
	</main>
	<!-- contents//end -->

	<!-- footer -->
	<%@ include file="../common/footer.jsp"%>
	<!-- //footer -->

</div>
<!-- //wrapper -->
</body>
</html>