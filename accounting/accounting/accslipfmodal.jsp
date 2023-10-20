<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
						   
						   <!-- 이 아래가(c:set~c:forEach) 있어야 ('non' vue.js) 모달 팝업창에 데이터 출력 ------------------------------------------------------ -->
						  <c:set var = "dv_amt_sum" value = "0" />
						   <c:set var = "en_amt_sum" value = "0" />
							<c:if test="${countaccslipflist eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>

							<c:forEach items="${accslipfmodal}" var="list">
									<tr>
										<td>${list.fnl_code}</td>					<!-- 전표번호 --> 
										<td>${list.bacc_name}</td>				<!-- 계정과목  -->
										<td>${list.dv_ep}</td>					<!-- 수입  -->
										<td>${list.dv_fee}</td>				<!-- 지출  -->
									</tr>
									
								<c:set var= "dv_amt_sum" value="${dv_amt_sum + list.dv_ep}"/>
								<c:set var= "en_amt_sum" value="${en_amt_sum + list.dv_fee}"/>
							</c:forEach>
							<!--  ----------------------------------------------------------------------------------  -->
							
							
							<!--  ----------------------------------------------------------------------------------------------------  -->
	
	<!-- {{item.bacc_code}}	{{item.bacc_name}}	{{item.dv_ep}}	{{item.dv_fee}} -->
	
		<%-- <div id="wrap_area2" class="layerPop layerType2" style="width: 900px; top: 111.5px; left: 220px; display: block;">
			<dl>
				<!-- 글씨 굵게 <dt>
					<strong>회계전표</strong>
				</dt> -->
				<dd style="height: auto;">
					<h1 style="font-size: 50px; height: 40px; padding-top: 2%; width: 50%;">회계전표2</h1>
			<div style="width:100%; height:200px; overflow:auto">		
					<table class="scrolltbody col" >
						<colgroup>
										<col width="91.11px">
										<col width="91.11px">
										<col width="91.11px">
										<col width="91.11px">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">전표번호</th>
								<th scope="col">계정과목</th>
								<th scope="col">지출</th>
								<th scope="col">수입</th>
								<!-- <th scope="col">합계</th> -->
							</tr>
						</thead>
						<!-- v-html : listResult ? listNotice ? -->
						
						<tbody  scope="col" id="listResult" class = "accSlipListModal" v-html="listResult">
									<tr v-for="(item,index) in listResult">
										<!-- <td>{{pageSize*(cpage-1)+1+index}}</td>   -->
										<td>{{item.bacc_code}}</td>
										<td>{{item.bacc_name}}</td>
										<td>{{item.dv_ep}}</td>
										<td>{{item.dv_fee}}</td>
										<td>{{dv_amt_sum + list.dv_ep}}</td>
										<td>{{en_amt_sum + list.dv_fee}}</td>
									</tr> 
								</tbody>			
						
						
						
						
						
						</tbody>
					</table>
				</div> --%>
					<%-- <table  class="col">
                        <colgroup>
								<col width="525px">
								<col width="247px">
								<col width="247px">
								<col width="1px">
								<col width="117.47px">
						</colgroup>
					      <tr>
					           <td style="font-weight:bold; color:#333; background-color:rgb(220,225,230);">합계 </td>
					           <td><div id="inamtarea"></div></td>					           
					           <td><div id="outamtarea"></div></td>	
					           <td style="background-color:rgb(220,225,230);"></td>				
					      </tr>
					</table> --%>
					<!-- <div class="btn_areaC mt20">
						 <a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div> -->
				<!-- </dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div> -->
    
    <!--  ------------------------------------------------------------------------------------------------------------  -->
							
							
							
							<%-- <div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
									<colgroup>
										<col width="3%">
										<col width="6%">
										<col width="9%">
										<col width="9%">
										<col width="8%">
									</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">계정코드</th>
										<th scope="col">계정과목</th>
										<th scope="col">지출</th>
										<th scope="col">수입</th>
									</tr>
								</thead>
							
							<!-- {{item.bacc_code}}	{{item.bacc_name}}	{{item.dv_ep}}	{{item.dv_fee}} -->
							
							<tbody id="listResult" >
									<tr v-for="(item,index) in listResult">
										<!-- <td>{{pageSize*(cpage-1)+1+index}}</td>   -->
										<td>{{item.bacc_code}}</td>
										<td>{{item.bacc_name}}</td>
										<td>{{item.dv_ep}}</td>
										<td>{{item.dv_fee}}</td>
										<td>{{dv_amt_sum + list.dv_ep}}</td>
										<td>{{en_amt_sum + list.dv_fee}}</td>
									</tr> 
								</tbody>				
							</table>
						</div> --%>
							
                           <input type="hidden" id="inamt" name="inamt" value="${dv_amt_sum}"/>
                          <input type="hidden" id="outamt" name="outamt" value="${en_amt_sum}"/>
						<input type="hidden" id="countaccslipflist" name="countaccslipflist" value="${countaccslipflist}"/>
                          