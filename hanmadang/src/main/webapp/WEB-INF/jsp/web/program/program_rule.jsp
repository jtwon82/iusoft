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
					<li class="by-4"><a href="/program/amount">분기 회원제 금액</a></li>
					<li class="by-4"><a href="/program/stadium">경기장 이용안내</a></li>
					<li class="by-4 is-selected"><a href="/program/rule">이용수칙 안내</a></li>
				</ul>
			</div>
			<article class="container-notice bg-program">
				<p>매월 첫째ㆍ셋째 주 월요일, 명절 연휴는 휴관일입니다.</p>
			</article>

			<article class="container">
				<div class="container-header"><h3 class="cl-program">한마당 체육관 이용수칙 안내</h3></div>
				<div class="table-basic-type4 line-box">
					<table>
						<caption>분기 회원제 금액에 대한 정보제공</caption>
						<colgroup>
							<col width="120px">
							<col width="220px">
							<col width="*">
						</colgroup>
						<thead>
							<tr>
								<th colspan="2">구분</th>
								<th>세부내용</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="2">운영 시간</td>
								<td class="col-left">
									<ul class="li-list">
										<li>평일(월 ~금) : 05:30 ~ 23:00</li>
										<li>토/일요일/국경일 : 07:00 ~ 22:00</li>
										<li>휴관 : 매월 첫째ㆍ셋째 주 월요일, 명절연휴</li>
										<li>GX/실용음악 프로그램 휴강일 : 휴관일/국경일/근로자의 날</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<div class="table-basic-under4">
										<table>
											<colgroup>
												<col width="120px">
												<col width="220px">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<td rowspan="5">회원모집 일정</td>
													<td>수강신청</td>
													<td class="col-left">
														<ul class="li-list">
															<li>회원모집(분기제) : <!-- 3월, 6월, 9월, 12월 18일 ~ 21일(4일간) -->수강신청 기간은 18~21일까지(4일간) 수강신청 및 추첨발표 후 접수(등록)를 실시</li>
															<li>접수(신청) : 포스코 한마당 홈페이지(www.poscohanmadang.co.kr) > 수강신청 응모 클릭</li>
															<li>추첨 및 공지 : 22일 오전 11:00 (포스코 한마당 홈페이지 공지)</li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>수강등록</td>
													<td class="col-left">
														<ul class="li-list">
															<li>22 ~ 26일(5일간) 현장(1F 안내데스크) 및 온라인 등록 가능<br>
															등록 : 현장 등록은 신규 및 재등록 회원, 온라인 등록은 재등록(ID 부여받은) 회원만 가능<br>
															<span style="font-size:17px;">※ 체육관 사정에 따라 등록기간은 변경될 수 있으며, 기간 내 등록하지 않을 시 대기 후보자에게 등록 기회 부여</span></li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>추가등록</td>
													<td class="col-left">
														<ul class="li-list">
															<li>28일부터 정원 마감 시까지 : 대기 후보자 우선 등록 후 미달종목에 한해 수시 등록</li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>등록시간</td>
													<td class="col-left">
														<ul class="li-list">
															<li>05:30~22:00(평일) / 07:00~21:00(주말,공휴일)<br>
															※ 단, 추첨발표 당일(22일)은 오전 11:00 이후 등록가능</li>
															<li>온라인 등록(홈페이지)은 26일 21:00 까지 가능</li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>신규등록 시 지참서류</td>
													<td class="col-left">
														<ul class="li-list">
															<li><span style="font-size:17px;">포스코 패밀리 : 직원 본인은 사원증, 경력증명서 / 가족은 직원신분증, 본인신분증, 가족관계 증빙서류(건강보험증)</span><br>
																※ 사원증 없을 시 출입카드(Ⅹ), 재직증명서 또는 경력증명서(○)</span></li>
															<li><span style="font-size:17px;">일반회원 : 거주지가 지곡동인 등본 또는 본인 신분증      ※ 준비서류 미확인 시 등록이 불가하오니 유의 바랍니다.</span></li>
														</ul>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<div class="table-basic-under4">
										<table>
											<colgroup>
												<col width="120px">
												<col width="220px">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<td rowspan="7">자격 기준</td>
													<td>공통</td>
													<td class="col-left">
														<ul class="li-list">
															<li>포스코 패밀리 : 포스코 직원 및 가족 / 포스코 0B 및 패밀리사 직원 및 가족<br> <span class="cl-red">(휘트니스, 패키지 프로그램은 직원 및 배우자에 한함)</span></li>
															<li>일반회원 : 지곡동 주민<br>
															※ 가족 : 직계가족 및 배우자 부모 포함</li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>휘트니스</td>
													<td class="col-left">
														<ul class="li-list">
															<li>포스코 패밀리 본인 및 배우자 / 일반회원 : 지곡동 주민</li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>GX<br>(Group Exercise)</td>
													<td class="col-left">
														<ul class="li-list">
															<li>포스코 패밀리 : 본인 및 가족 / 일반회원 : 지곡동 주민 / 14세 이상(중학생) 등록 가능<br>
															※ 단, 14세 미만(초등생) 부모동반등록 및 강습 참가</li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>스피닝 / 스쿼시</td>
													<td class="col-left">
														<ul class="li-list">
															<li>포스코 패밀리 : 본인 및 가족 / 일반회원 : 지곡동 주민 / 14세 이상(중학생) 등록 가능</li>
														</ul>
													</td>
												</tr>
<!-- 												<tr> -->
<!-- 													<td>스크린승마</td> -->
<!-- 													<td class="col-left"> -->
<!-- 														<ul class="li-list"> -->
<!-- 															<li>14세 이상(중학생) 등록 가능 / 키 150cm 이상, 90kg 미만 등록 가능</li> -->
<!-- 														</ul> -->
<!-- 													</td> -->
<!-- 												</tr> -->
												<tr>
													<td>다이어트 발레</td>
													<td class="col-left">
														<ul class="li-list">
															<li>포스코 패밀리 : 본인 및 배우자 및 가족 / 일반회원 : 지곡동 주민      ※ 대상 : 성인(20세 이상)</li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>패키지 프로그램</td>
													<td class="col-left">
														<ul class="li-list">
															<li>포스코 패밀리 : 본인 및 배우자 / 일반회원 : 지곡동 주민</li>
														</ul>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<div class="table-basic-under4">
										<table>
											<colgroup>
												<col width="120px">
												<col width="220px">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<td rowspan="2">환불</td>
													<td>규정</td>
													<td class="col-left">
														<ul class="li-list">
															<li>카드 결제 : 등록 금액 취소 후 이용금액 재결제</li>
															<li>현금 결제 : 등록 금액에서 이용금액 공제 후 현금 환불</li>
															<li>사용 개시일 전 : 총 등록 금액의 10% 공제 후 반환</li>
															<li>사용 개시일 이후 : 취소일 전까지의 이용일 수에 해당하는 금액 + 총 등록 금액의 10% 공제 후 반환</li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>절차</td>
													<td class="col-left">
														<ul class="li-list">
															<li>체육관 방문 후 환불 신청서 작성 → 환불 신청(등록 시 결제한 카드 제출) → 등록 시 결제 총금액 취소 후 이용금액 재결제<br>
															※ 환불 대리신청자는 위임장 작성, 제출</li>
														</ul>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<div class="table-basic-under4">
										<table>
											<colgroup>
												<col width="120px">
												<col width="220px">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<td rowspan="2">연기</td>
													<td>규정</td>
													<td class="col-left">
														<ul class="li-list">
															<li>장기 입원 및 출장만 증빙서류 제출(진단서, 확인서, 소견서 등)</li>
															<li>연기 기간 : 2회 (1회 최대 30일)</li>
															<li>개인사유 연기 불가, 환불규정에 의거 환불조치</li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>절차</td>
													<td class="col-left">
														<ul class="li-list">
															<li>체육관 방문 후 연기 신청서 작성 및 증빙서류 제출 → 심의 후 연기 가능 여부 결정</li>
														</ul>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td>강습</td>
								<td>규정</td>
								<td class="col-left">
									<ul class="li-list">
										<li>프로그램(강습반) 변경 불가</li>
										<li><span style="font-size:17px;">강습시간 30분 전부터 입장 가능 / 입장 시 회원카드 제출/핸드키 발급 후 입장 (단, 핸드키 미착용 시 입장 불가)</span></li>
										<li>프로그램 이용 시 1일 1회 입장을 원칙으로 함 (단, 이용시간은 퇴장까지 3시간 이내로 규정함)</li>
										<li>회원카드 및 핸드키 임의 양도 양수행위 시 이용 제한 "적용 절차" 적용</li>
										<li>강습 시간 50분 ★<br>※ 토요일 / 일요일 / 국경일 / 임시공휴일 / 근로자의날 휴강</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<div class="table-basic-under4">
										<table>
											<colgroup>
												<col width="120px">
												<col width="220px">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<td rowspan="4">이용 수칙</td>
													<td>휘트니스</td>
													<td class="col-left">
														<ul class="li-list">
															<li>실내전용 운동화, 운동복 착용 후 이용</li>
															<li>센터 내 개인레슨 금지</li>
															<li>1일 1회 입장을 원칙으로 함 (단, 이용시간은 퇴장까지 3시간 이내로 규정)</li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>패키지 프로그램</td>
													<td class="col-left">
														<ul class="li-list">
															<li>1일 2회 입장 가능(1회 입장 시 1개 종목 이용)</li>
															<li>1일 1회 입장 시 2개 종목 동시 이용 가능(2개 종목 동시 이용 시 1회 입장으로 제한)</li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>주 경기장 / 당구 / 탁구<br>(배드민턴, 농구, 배구, 족구)</td>
													<td class="col-left">
														<ul class="li-list">
															<li>회사 행사 및 대관(예약) 신청자 선 이용(홈페이지를 통해 일정 확인)</li>
															<li>배드민턴 예약 및 선착순 접수(직원 예약 가능/일반인 선착순 이용)<br>
															※ 당·탁구 선착순 이용(라켓 및 공 대여)</li>
															<li>배드민턴 라켓 대여 가능 : 경기장 입구(관리 담당자) 문의, 사용 후 반납</li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>동아리실<br>(동호회룸 포함)</td>
													<td class="col-left">
														<ul class="li-list">
															<li>대상/방법 : 직원 본인(패밀리사 포함) 및 해당 분기 등록된 회원<br>
															※ 단, 회사행사는 주관부서(담당자) 협의 후 예약 이용 가능</li>
															<li>용도 : 회의 및 악기 연습(최대 2시간)</li>
														</ul>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">운동복</td>
								<td class="col-left">
									<ul class="li-list">
										<li>휘트니스(패키지) 회원만 운동복 지급 ※ 기타 종목 개인 운동복 지참(이용)</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td colspan="2">핸드키 / 회원카드</td>
								<td class="col-left">
									<ul class="li-list">
										<li>핸드키(락커키) 분실 시 10,000원 배상 책임</li>
										<li>회원카드 재발급 비용 3,000원<span style="color:red;">(현금)</span><br>※ 최초 무료발급</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<div class="table-basic-under4">
										<table>
											<colgroup>
												<col width="120px">
												<col width="220px">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<td rowspan="2">개인 신발장</td>
													<td>규정</td>
													<td class="col-left">
														<ul class="li-list">
															<li>3개월 사용료 6,000원 (1개월 사용료 2,000원)</li>
															<li>매월 1일부터 대여 기간 적용</li>
															<li>이용기간 이후 미반납 시 이용료 발생 (일별금액 산정)</li>
														</ul>
													</td>
												</tr>
												<tr>
													<td>환불</td>
													<td class="col-left">
														<ul class="li-list">
															<li>7일 사용 전 : 월 사용료 전액 환불</li>
															<li>7일 사용 후 : 1개월 사용으로 간주(환불금액 없음)</li>
															<li>만기일 전 반납 필수 (단, 만기일 이후 반납이 없을 시 자동 반납 처리하고 개인 소지품 15일 보관)</li>
															<li>개인 소지품 15일 보관 후 사회복지기관 기증 또는 폐기</li>
														</ul>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">귀중품 보관</td>
								<td class="col-left">
									<ul class="li-list">
										<li>금전 및 귀중품은 반드시 안내테스크에 보관 후 입장</li>
										<li>개인 소지품 및 현금 분실은 본인 책임</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td colspan="2">시설파손</td>
								<td class="col-left">
									<ul class="li-list">
										<li>개인 부주의에 의한 시설 파손 및 분실은 이용자 부담을 원칙으로 함</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td colspan="2">이용 제한</td>
								<td class="col-left">
									<ul class="li-list">
										<li>체육시설 이용질서를 위해 하는 회원(규정 위반)</li>
										<li>직원 및 강사의 통제에 불응하거나 강습 분위기를 어지럽히는 행위</li>
										<li>강습 시 회원간 마찰로 강습을 방해하는 행위</li>
										<li>욕설, 성희롱, 성추행 등 불쾌감을 주는 행위</li>
										<li>샤워실 내 오일, 마사지팩 사용 및 세탁행위</li>
										<li>모금 및 판매 행위 또는 음주 후 운동하는 회원</li>
										<li>미등록 프로그램 수강 / 회원카드 임의 양도 양수행위</li>
										<li>기타 기초 질서를 미준수하는 행위</li>
										<li>적용절차<br>1차 적발 구두경고 → 2차 적발 동의서작성 → 3차 적발 즉시 회원자격 박탈</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td colspan="2">기타</td>
								<td class="col-left">
									<ul class="li-list">
										<li><span style="font-size:17px;">체육관 사정에 따라 회원모집 일정 및 프로그램 운영일, 강습시간, 지도교사 등 운영방침이 변경이 있을 수 있음</span></li>
										<li>강습 프로그램은 모집정원 50% 미만 접수 시 폐강 이 될 수 있음</li>
										<li>질병 혹은 건강에 이상이 있는 사람은 상담 후 접수</li>
										<li>체육관 실내 전 지역 금연(벌금 200만원) 및 애완견 출입통제</li>
										<li>주 경기장 단체 대관문의는 포스코(주관부서 - 담당자) 문의 바람<br>
										※ 포스코 행사 시 이용이 제한될 수 있음 / 단, 주말 13시 이후는 일반 이용자를 위해 회사행사 지양</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td colspan="2">휘트니스 일일입장제 이용 규정</td>
								<td class="col-left">
									<ul class="li-list">
										<li>이용대상<br>
										○ 직원, 등록 이력자, 등록 이력 없는 가족(배우자,부모,자녀)은 직원 동반시에만 이용 가능<br>
										※ 휘트니스 등록 이력자에 한함<br>
										요금은 휘트니스 분기 회원 규정에 준함(포스코 패밀리 회원-2천원, 일반회원-5천원)<br>
										※ 직원 배우자는 포스코 패밀리 회원(2천원), 자녀는 일반회원(5천원) 요금 적용</li>
										<li>운영시간<br>
										○ 평일 05:30 ~ 17:00 까지 입장(18시까지 퇴장) / 주말 또는 국가공휴일은 07:00~22:00까지</li>
										<li>지참서류<br>
										○ 직원 : 사원증<br>
										○ 직원가족 : 가족관계 확인용 증빙서류(가족관계증명서, 건강보험증, 신분증 등)</li>
										
										<li>제한사항<br>
										○ 동 시간대 입장인원 제한(남/여 각 10명), 14세 이상 입장 가능<br>
										○ 안전사고 예방을 위해 신규 이용은 제한(등록 회원에 한함)
										</li>
										<li>체육시설 이용질서 규정 위반<br>
										○ 직원 및 강사의 통제에 불응하거나 강습 분위기를 어지럽히는 행위  <br>
										○ 욕설, 성희롱, 성추행 등 불쾌감을 주는 행위  <br>
										○ 샤워실 내 오일 / 마사지 팩 사용 / 세탁행위  <br>
										○ 모금 및 판매 행위 또는 음주 후 운동 하는 회원  <br>
										○ 입장권 임의 양도 양수행위 및 기타 기초 질서를 미 준수하는 행위  <br>
										※ 위 사항에 2가지 이상 위배 시 3차 적용  <br>
										※ 1차 적발 구두경고 / 2차 적발 동의서작성 / 3차 퇴장  <br>
										</li>
										
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