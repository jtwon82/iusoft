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
			<div class="container-tabs cl-rent">
				<ul>
					<li class="by-3"><a href="/rent/main">예약하기</a></li>
					<li class="by-3"><a href="/rent/confirm">예약 확인 및 취소</a></li>
					<li class="by-3 is-selected"><a href="/rent/rule">이용규정</a></li>
				</ul>
			</div>
			<article class="container-notice bg-rent">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>

			<article class="container">
				<div class="container-header"><h3 class="cl-rent">한마당 체육관 [일일 프로그램] 대관 및 이용 규정</h3></div>
				<div class="table-basic table-basic-type3 line-box">
					<table>
						<caption>한마당 체육관 [일일 프로그램] 대관 및 이용 규정에 대한 정보제공</caption>
						<colgroup>
							<col width="110px">
							<col width="110px">
							<col width="650px">
							<col width="*">
						</colgroup>
						<thead>
							<tr>
								<th colspan="2">구분</th>
								<th>세부내용</th>
								<th>비고</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="2">공통(운영)</td>
								<td class="col-left">
									<ul class="li-list li-thin">
										<li>회사 공식 행사 및 대관(예약) 이용을 우선 합니다</li>
										<li>운영시간 : 주경기장(배드민턴) 07:00 ~ 22:30 ｜ 당·탁구장 09:00 ~ 22:30<br>
										※ 휴관 : 매월 첫째/셋째 주 월요일, 명절 연휴</li>
									</ul>
								</td>
								<td class="col-left">
									<ul class="li-list li-thin">
										<li>주 경기장 운영 준비 시간<br> 06:00 ~ 07:00 (60’)</li>
									</ul>
								</td>
							</tr>
							
							<tr>
								<td>대관(예약)</td>
								<td colspan="3">
									<div class="table-basic-under4">
										<table>
											<colgroup>
												<col width="110px">
												<col width="650px">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<td>공통</td>
													<td class="col-left">
														<ul class="li-list li-thin">
															<li>대상 : 포스코 그룹사, 협력사 직원 예약 가능     ※ 지역주민 현장 선착순 이용</li>
															<li>회사 공식 행사 및 구기 종목의 날 예약 신청은 담당자에게 문의 (220 - 1155)</li>
															<li>이용 시 예약 신청한 본인이 현장(배드민턴:1F 안내대 / B1F 당·탁구장) 방문하여 확인 및<br> 금액 결제 후 이용 가능</li>
														</ul>
													</td>
													
													<td>
													<ul class="li-list li-thin">
														<li>주 경기장(배드민턴) 클리닝타임 이용제한<br> 18:00 ~ 18:30 (30')</li>
													</ul>
													</td>
												</tr>
												<tr>
													<td>회사행사</td>
													<td class="col-left">
														<!-- <a href="/web/hanmadanggymnasium.pptx" class="btn btn-level1 btn-rent fr">대관 신청서 다운로드</a> -->
														<ul class="li-list li-thin">
															<li>1순위(이용일 포함 30일전부터 선착순 예약 신청)     ※ 이용료 없음</li>
															<li>공평한 이용기회를 부여하고자 횟수 제한 있음(스텝부서 팀 단위 이용제한)<br>
																▷ 주 경기장(구기 종목포함):2회/월<br>
																▷ 배드민턴 2회/월<br>
																▷ 당·탁구장 2회/월 (단, 시간 및 코트 제한 없음)</li>
															<li>종목별 최대 배드민턴 6코트, 탁구 6코트, 당구(사구 3면, 포켓 1면)까지 예약 가능</li>
															<li>예약 절차 : 홈페이지에서 대관신청서 다운로드 후 작성 <a href="/web/hanmadanggymnasium.pptx"><b>[대관신청서 다운로드]</b></a> → 부서장 결재<br> → 체육관 담당자에게 메일 송부
															→ 담당자 예약등록</li>
															<li>이용 당일 반드시 결재권자 동반하여 이용 가능</li>
														</ul>
													</td>
													<td class="col-middle" rowspan="2">
														<!-- <a href="/web/hanmadanggymnasium.pptx" class="btn btn-level1 btn-rent fr">대관 신청서</a><br><br><br><br><br> -->
														<ul class="li-list li-thin">
															<li style="color:red">포스코 그룹사, 협력사<br>1회/년 대관 이용 가능<br>(공평한 이용 기회 부여)<br>&nbsp;<br>&nbsp;<br>&nbsp;</li>
<!-- 															<li>주말(토/일) 13시 이후 [회사행사] / [동호회] 예약 제한<br>[직원(일반)] 선착순 예약 가능<br>&nbsp;</li> -->
															<li>탁구 · 당구 예약 방법<br>대관신청서 작성 → 체육관 담당자에게 메일 송부 → 담당자 예약 등록
															</li>
														</ul>
														<!-- <br><br>
														<a href="/web/hanmadang_team.docx" class="btn btn-level1 btn-rent fr">동호회 등록 신청서</a> -->
													</td>
												</tr>
												<tr>
													<td>동호회</td>
													<td class="col-left">
														<!-- <a href="/web/hanmadang_team.docx" class="btn btn-level1 btn-rent fr">동호회 등록 신청서 다운로드</a> -->
														<ul class="li-list li-thin">
															<li>2순위(이용일 포함 15일 전 13시 부터 신청) *2일전 24시까지 동호회 예약
															<li>한마당 체육관 이용 동호회로 등록 후 예약<br>
															▷ 체육관 등록 자격 : 동호동락(포스코)에 정식으로 승인된 10인 이상 동호회에 한함<br>
															▷ 체육관 등록 절차 : 체육관 방문 → 회원명부 및 신청서 작성 후 제출 <a href="/web/hanmadangteam.docx"><b>[동호회 신청서 다운로드]</b></a><br>(회원 : 포스코 패밀리사 및 포스코 OB직원·가족, 지역주민)<br>
															※ 단, 지역주민은 소속동호회 회원(직원 및 가족) 대비 15%까지 등록 가능<br>
															※ 단, 체육관 이용 동호회 등록시 1인 1동호회 등록 <br>
															<li>종목별 최대 배드민턴 6코트(동시간), 탁구 6코트, 당구(사구 3면, 포켓 1면)까지 가능<br>
															※ 단, 각 종목별 총 예약 코트는 회사 행사로 예약 된 코트를 제외한 빈 예약 코트에 한 함</li>
															<li>예약 절차 : 최초 15일전 13시부터 익일 12시까지 신청 → 신청건 OVER시 추첨 → 13시 결과 발표 후 빈 예약 코트 선착순 등록</li>
															<li>이용 시 회사 · 동호회 예약코트 추가코트([직원(일반)] 예약 코트) 선점하여 이용 시 페널티 부여<br>
															※ 단, 당일 빈 코트 현장 발권이용은 예외 </li>
															<li>동호회 예약 후 체육관 등록 동호회 소속이 아닌 회원과 함께 이용 시 페널티 부여</li>
															<li>기타 편법적인 방법을 통해 코트 선점하여 이용 시 페널티 부여 </li>
														</ul>
													</td>
													<!-- <td class="col-left">
														<a href="#none" class="btn btn-level1 btn-rent">동호회 등록 신청서 다운로드</a>
													</td> -->
													
												</tr>
												<tr>
													<td>직원</td>
													<td class="col-left" colspan="2">
														<ul class="li-list li-thin">
															<li>3순위(1일전 13시부터 예약 등록)     ※ 이용 시간 기준 2시간 전까지 예약 가능<br>
															▷ 배드민턴만 예약 가능     ※ 당·탁구장 현장 선착순 이용</li>
															<li>예약 절차 :  배드민턴 예약 현황 확인(홈페이지) → 빈 예약 코트 선착순 등록(최대 1코트 2시간까지 가능)<br>
															※ 1시간 예약가능</li>
															<li>예약 후 본인이 직접(대리 발권 불가) 현장 발권 후 이용(예약 직원 없이 일반인 이용 시 페널티 부여)</li>
															<li>이용 2시간 전부터 발권  *예약 시간 10분까지 연락 없이 미 발권 시 자동 취소 후 페널티 부여</li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>취소</td>
													<td class="col-left" colspan="2">
														<ul class="li-list li-thin">
															<li>포스코 한마당 체육관 홈페이지(www.poscohanmadang.co.kr) [대관스케줄]에서 취소 가능</li>
															<li>예약 후 [회사행사]/[동호회] 이용일 포함 2일 전, [직원(일반)] 이용 2시간 전까지 취소 가능</li>
															<li>예약 후 무단으로 이용하지 않거나, 취소규정 및 타인 양도행위 등 위반 시 패널티 부여</li>
														</ul>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">구기 종목의 날<br>(주 경기장)</td>
								<td class="col-left">
									<ul class="li-list li-thin">
										<li>운영일 : 매주 [수요일] 18:30 ~ 22:30 ｜ [일요일] 07:00 ~ 11:00     ☆ 주 2회 운영</li>
										<li>종목 : 배구 / 농구 / 족구(2코트) 중 1가지 선택</li>
										<li>이용 : 회사 행사 및 동호회 예약 후 이용 가능     ☆ 일반 이용 불가<br>
										※ 이용 3일 전까지 예약 없을 시 배드민턴 [직원(일반)] 예약일에 맞춰 배드민턴 예약 가능</li>
									</ul>
								</td>
								<td class="col-left">
									<ul class="li-list li-thin">
										<li>구기 종목의 날 예약 방법<br>
										▷ 대관신청서 작성 → 체육관 <br>담당자에게 메일 송부 → 담당자 <br>예약 등록</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td colspan="2">이용요금</td>
								<td class="col-left" colspan="2">
									<ul class="li-list li-thin">
										<li>동호회 및 일반(직원), 사외기관 대관신청시 실비 사용금액 부과 (전기, 급수, 냉난방, 청소등)<br>
											☆ 체육관 전체 대관시 운영사무실 문의<br>
											▷ 구기종목 : 1시간 10,000원 <br>
											▷ 배드민턴 : 1시간 2000원 (코트 기준)<br>
											▷ 당·탁구장 : 1시간 3000원(10분 / 500원, 테이블 기준)</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td colspan="2">환불</td>
								<td class="col-left" colspan="2">
									<ul class="li-list li-thin">
										<li>이용시간 시작 전 : 전액 환불</li>
										<li>이용시간 시작 후 : 환불 없음     ☆ 당·탁구장 후불 계산</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td colspan="2">이용 제한</td>
								<td class="col-left" colspan="2">
									<ul class="li-list li-thin">
										<li>[주 경기장], [당·탁구장] 이용질서를 위해 하는 회원(규정 위반)<br>
											▷ 체육관 직원의 통제에 불응하거나 분위기를 어지럽히는 행위<br>
											▷ 주 경기장 입장 시 실내용 운동화 착용 후 입장<br>
											▷ 음주 후 운동하는 회원 (구두, 안전화 등산화 등 외부에서 착용한 신발 입장제한)<br>
											▷ 체육관 및 당,탁구장 음식물 반입금지<br>
											▷ 모금 및 판매(영업)하는 행위<br>
											▷ 샤워장 이용 시 규칙 준수와 청결 상태 유지<br>
											▷ 애완동물(반려견 등) 출입 금지</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td colspan="2">패널티</td>
								<td class="col-left" colspan="2">
									<ul class="li-list li-thin">
										<li>1차 : 1주일 이용제한</li>
										<li>2차 : 1개월 이용제한</li>
										<li>3차 : 퇴출</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td colspan="2">기타</td>
								<td class="col-left">
									<ul class="li-list li-thin">
										<li>시설 파손 : 이용자 부주의로 인한 시설 파손은 이용자 부담을 원칙으로 합니다</li>
										<li>물품 분실 : 주 경기장, 당·탁구장, 탈의실등 이용 시 귀중품 및 개인물품 분실은 본인의 책임이며,<br>체육관에서는 일체 책임지지 않습니다</li>
									</ul>
								</td>
								<td class="col-left">
									<ul class="li-list li-thin">
										<li>탈의실 이용시 안내데스크에서<br>락커키 발급받아 이용가능</li>
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
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