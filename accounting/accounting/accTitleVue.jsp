<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 계정과목관리  </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 10;    	
	var pageBlockSize = 5;		
	var listarea;
	var listarea2;
	var listarea3;
	var listarea4;
	
	/** OnLoad event */ 
	/* $(function() {
		
		AccTitlelist();		
		// -----------------------------
		selectComCombo("acc","accall","all","",""); 
	    selectComCombo("acc","paccall","all","",""); 	
	    // selectComCombo("accd", "accdall", "all", "", ""); 
	    
		fn_init();
		// -----------------------------------
		fRegisterButtonClickEvent();
		searchempTa();
	}); */
	$(function() {
		//AccTitlelist();		
		AccTitlelist_init();
		
		fn_init();
		fRegisterButtonClickEvent();
		
		//searchempTa();
		searchempTa_init();
	   
	});
	
	// 버튼 이벤트 등록
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
			
			var btnId = $(this).attr('id');
			switch (btnId) {
				case 'btnSearch' : 
					AccTitlelist();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnUpdate' : 
					AccTitlesave();
					break;
				case 'btnSave' :
					AccTitlesave();
					break;	
				case 'btnInsert' :
					AccTitle();
					break;	
			}
		});
	}
	// --------------------------------------------------------------
	
 	/* function fn_init(){
			//main
		listarea = new Vue({
			el : "#wrap_area",
			data : {
			pageSize : 10,
			pageBlockSize : 5,
			bacc_code : '',
			dacc_code : '',
			R_F : '',
			S_daccT : '',
			cpage : '',	
			},
			methods : {
				
			} // methods ended
	})	// listarea ended
	}	// fn_init ended	 */
	
	// -----------------------------------------------------------------------------------------------
	function fn_init(){
		
		//cpage = cpage || 1;
		
		//main
      selectComCombo("acc","accall","all","",""); 
      selectComCombo("acc","paccall","all","",""); 	
		
	
      $("#accall").change(function() {
			selectComCombo("accd", "accdall", "all", $("#accall").val(), "");  // 계정 상세 분류
		});
      
      //searchempTa_init();
      //AccTitlelist_init();
      
	} 
// ---------------------------------------------------------------------------------------------------------------------
	
		
	function searchempTa_init() {
			
			$("#accall").val($("#Saccall").val());
			$("#accdall").val($("#Saccdall").val());
			$("#R_F").val($("#SR_F").val());
			$("#S_daccT").val($("#S_daccT").val());
			
	
			// ----------------------------
			//cpage = cpage || 1;
			
			listarea = new Vue({
				el : "#wrap_area",
				data : {
					//accall : "",
					//Saccall : "",
					//Saccdall : "",
					
					bacc_code : '', 
					dacc_code : '', 
					R_F : "",
					// SR_F : "",
					S_daccT : "",
					cpage : '',
					pageSize : 10,
					pageBlockSize : 5,
					listNotice : [] ,
					//listResult : [],
					modallist : [],
				}, 
				methods : {
					fn_searchempTa : function(){
						searchempTa();
					}
				} // methods ended
			}); // listarea ended
}//function searchempTa_init ended ...

	
	function searchempTa(cpage){
	
		
		cpage = cpage || 1;
		
		var param = {
				bacc_code : listarea.bacc_code,    // cannot be read
				dacc_code : listarea.dacc_code,   // cannot be read
				R_F : listarea.R_F,
				s_dacct : listarea.S_daccT,
				pageSize : listarea.pageSize,
				cpage : cpage,
			}
		
			if(!cpage) {
				//param.bacc_code = listarea.bacc_code;
				param.cpage = 1;
				cpage = 1;
			}
			
			
			
				var listcallback = function(returndata){
				
				//console.log("callback부분 : " + JSON.stringify(returndata));
				// here, returndata contains listAccTitle with 
				// [[[ bacc_code, dacc_code, dacc_name, dacc_div(null),
				// dacc_detail, use_yn, bacc_name ]]]
				//console.log(returndata);
				/* console.log('======= return data : ' + returndata);
				console.log('######################')
				console.log('listAccTitle : ' + returndata.listAccTitle);
				console.log('%%%%%%%%%%%%%%%%%%%%%') */
				
				listarea.listNotice = returndata.listAccTitle;
				// in SQL query, listAccTitle contains bacc_code, bacc_name, dacc_code, dacc_name, detail_name,
				//dacc_detail, use_yn,
				
				var counthnoticelist= returndata.counthnoticelist;
				// pageBlockSize taken out getPaginationHtml();
				var paginationHtml = getPaginationHtml(cpage, counthnoticelist, listarea.pageSize, listarea.BlockSize, 'searchempTa');
		
				// memo : ... class='hidden'>맨앞</span></a><a class='pre' href='javascript:searchempTa(NaN)'> ...
				// memo : href='javascript:searchempTa(NaN)'
				console.log('pagination Html : ' + JSON.stringify(paginationHtml));
				//console.log('returndata : '+JSON.stringify(retuvarndata));
				//listarea.pagingnavi = paginationHtml;
				
				//console.log('paging navi : '+JSON.stringify(listarea.pagingnavi));
				//console.log('cpage : '+cpage);
				//pagingnavi = paginationHtml;
				//listarea.noticePagination = paginationHtml;
				listarea.cpage = cpage;
				
			}
			// error1 here ...
			callAjax("/accounting/listAccTitleVue.do", "post", "json", "true", param, listcallback) ;
		}	// searchempTa ended
		// text -> json
		
   function AccTitlelist_init() {
		
	   //cpage = cpage || 1;
		
	 	listarea3 = new Vue({
			el : "#wrap_area",
			data : {
				accall : '',
				bacc_code : '',
				dacc_code : '',
				R_F : '',
				S_daccT : '',
				pageSize : 10,
				cpage : '',
			},
			methods : {
				fn_AccTitlelist:function(){
					AccTitlelist();
				}
			}, // methods ended
		}); // listarea3 ended 
	   		// console.log(param); 
		}
		 
   function AccTitlelist(cpage){
	   
	   cpage = cpage || 1;
		
	   var param = {
				  // listAcc : listarea3.listAccTitle,
				   //Saccall : listarea3.accall,
				   //Saccdall : listarea3.accdall,
				   
				  // bacc_code : listarea3.bacc_code,
				   //dacc_code : listarea3.dacc_code,
				   
				   //SR_F : listarea3.R_F,
				   //R_F : listarea3.R_F,
				   //S_daccT : listarea3.S_daccT
				   bacc_code : $("#accall").val()  
				   ,dacc_code : $("#accdall").val()
				   ,R_F : $("#R_F").val() 
				   ,S_daccT : $("#S_daccT").val()
			       ,pageSize : pageSize
			       ,cpage : 1   
		}
		console.log ( "param : " + param);
		
		   var AccTitlelistcallback = function(returndata) {
						
			   /* $("#listAcc").empty().append(returndata);	
				$("#Saccall").val($("#accall").val());
				$("#Saccdall").val($("#accdall").val());
				$("#SR_F").val($("#R_F").val());
				$("#S_daccT").val($("#S_daccT").val());
				    */
			
				var counthnoticelist= returndata.counthnoticelist;
				var paginationHtml = getPaginationHtml(cpage, counthnoticelist, pageSize, pageBlockSize, 'searchempTa');
				//listarea3.pagingnavi =  paginationHtml;
	   	} 
			// error1 here ...
		  callAjax("/accounting/listAccTitleVue.do", "post", "json", "true", param, AccTitlelistcallback);
			// text -> json
	   }

 // ------MODAL----------------------------------------------------------------------------------------------------------------  
   
		//모달실행
		function AccTitle() {
				   
				   initpopup();		   
			   
				   gfModalPop("#AccTitlereg");
				   
		   }
		
	   
		function AccTitlesave() {
			
			if(!fValidate()) {
				
				return;
			}
			var param = {
					bacc_code  : $("#paccall").val(),  
					bacc_name	: $("#bacc_name").val(),
					dacc_name  : $("#dacc_name").val(),  
				    dacc_detail : $("#dacc_detail").val(),
				    dacc_div : $("#dacc_div").val(),
				    dacc_code : $("#dacc_code").val(),
				    use_yn: $("#use_yn").val(),
					action : $("#action").val(),
			}
			
			var savecallback = function(returndata) {
				
				console.log(  JSON.stringify(returndata) );
				
				if(returndata.result == "SUCCESS") {
					alert("저장 되었습니다.");
					gfCloseModal();
					
					if($("#action").val() == "U") {
						AccTitlelist($("#currentpage").val());
					} else {
						AccTitlelist();

					}
					
				}
			}
			
			callAjax("/accounting/saveAccTitle.do", "post", "json", false, param, savecallback) ;
			
		}
		
		  
	   function initpopup(object) {
			   
		   if( object == "" || object == null || object == undefined) {   // 신규
			   $("#paccall").val("");
			   $("#bacc_name").val("");
			   $("#dacc_name").val(""); 
			   $("#dacc_div").val("").prop("selected", true);;
			   $("#dacc_detail").val("");
			   $("#dacc_code").val("");
			   $("#use_yn").val("Y")
			   
			   $("#bacc_name_ro").show ();
			   $("#btnUpdate").hide();
			   $("#btnSave").show();
			   $("#use_yn_up").hide();
			   $("#bacc_name_rd").hide();
			   $("#dacc_code_rd").hide();
			   $("#action").val("I");
			   
		   } else {
			   $("#paccall").val(object.bacc_code);
			   $("#dacc_code").val(object.dacc_code).prop("readonly", true);
			   $("#paccall_rd").val(object.bacc_name).prop("readonly", true);
			   $("#dacc_name").val(object.dacc_name);
			   $("#dacc_div").val(object.dacc_div).prop("selected", true);
			   $("#dacc_detail").val(object.dacc_detail);
			   $("#use_yn").val(object.use_yn).prop("selected", true);
			   $("#detail_name").val(object.detail_name);
			   			   	
			   $("#btnUpdate").show();
			   $("#btnSave").hide();
			   $("#bacc_name_ro").hide();
			   $("#use_yn_up").show();
			   $("#bacc_name_rd").show();
			   $("#dacc_code_rd").show();
			   $("#action").val("U"); 
			   
		   }
	   }

	   function fn_selectAccTitle(dacc_code, bacc_code) {
		   
		   var param = {
				   dacc_code : dacc_code,
				   bacc_code : bacc_code
		   }
		   
		   var selectAccTitlecallback = function(returndata) {
			   console.log( "체크", JSON.stringify(returndata)  );
			   
			    	initpopup(returndata.selectAccTitle);

			    	
			    	gfModalPop("#AccTitlereg")
			 
		   }
		   
		   callAjax("/accounting/selectAccTitle.do", "post", "json", false, param, selectAccTitlecallback);
	   }
	   
	  
// ---- MODAL ---------------------------------------------------------
	   
	   function fValidate() {
	    	
		   var chk = true;
		   console.log("SFDsdfsdfsdfsdf");
		   
			if($("#action").val() == "I"){
				chk = checkNotEmpty(
						[
								[ "paccall", "계정대분류명을 선택해 주세요." ]
							,	[ "dacc_name", "계정세부명을 입력해 주세요" ]
							,	[ "dacc_detail", "상세내용을 입력해 주세요" ]
							,	[ "dacc_div", "구분을 선택해 주세요" ]
							,	[ "use_yn", "사용여부를 선택해 주세요" ]
						]
				)
			}else if ($("#action").val() == "U"){
				chk = checkNotEmpty(
						[
							[ "dacc_name", "계정세부명을 입력해 주세요" ]
						,	[ "dacc_detail", "상세내용을 입력해 주세요" ]
						,	[ "dacc_div", "구분을 선택해 주세요" ]
						,	[ "use_yn", "사용여부를 선택해 주세요" ]
					]
				)
			}
			
			if (!chk) {
				return;
			}
			return true;
		}
 
	  

	  
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myform" action="" method="">
	
    <input type="hidden" id="currentpage"  id="currentpage" value="">
	<input type="hidden" name="action" id="action" value=""> 
	<input type="hidden" id="loginId"  name="loginId"  value="${loginId}">
	<input type="hidden" id="loginId"  name="loginId"  value="">
<%--     <input type="hidden" id="bacc_codeT"  name="bacc_codeT"  value="${bacc_codeT}"> --%>
    
	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
							<a href="" class="btn_nav bold">회계</a> 
								<span class="btn_nav bold">계정과목관리</span> 
								<a href="/accounting/acctitle.do" onclick="window.location.reload()" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>계정과목관리</span> <span class="fr"> 
								<a class="btnType blue" href="" name="btn" id="btnInsert" >
								<span>등록</span></a>
								
							</span>
						</p>
						
					<!--검색창  -->
					<table width="100%" cellpadding="5" cellspacing="0" border="1"
                        style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 10px; border-color: blue" align="center">
							<td width="100" height="25" style="font-size: 100%">계정대분류</td>
							<td><select id="accall" name="accall"  v-model="accall">	</select></td>
        					<td width="100" height="25" style="font-size: 100%">계정중분류</td>
        					<td><select id="accdall" name="accdall" v-model="accdall">
        						<option value="" >전체</option>
        						</select></td>
							<td width="100" height="25" style="font-size: 100%">구분</td>
							<td><select id="R_F" name="R_F" style="width:100px">
								<option value="" >전체</option>
								<option value="1" >지출</option>
								<option value="2" >수입</option>
							</select></td>          
							<td width="100" height="25" style="font-size: 100%">사용여부</td>
                           		<td><select id="S_daccT" name="S_daccT"  style="width:100px">
                           			<option value="" >전체</option>
                          		 	<option value="Y" >Y</option>
									<option value="N" >N</option>
                           			</select></td>        
                       	   <td width="110" height="60" style="font-size: 120%">
                   						   <a href="javascript:AccTitlelist();" class="btnType blue" id="btnSearch" name="btn"><span>조회</span></a></td>
                        </tr>
						                        
                     </table>    
						
						
						<div class="divAccTitleList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="10%">
						                   <col width="35%">
						                   <col width="8%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">계정대분류코드</th>
							              <th scope="col">계정대분류명</th>
							              <th scope="col">계정세부코드</th>
							              <th scope="col">계정세부명</th>
							              <th scope="col">구분</th>
							              <th scope="col">상세내용</th>
							              <th scope="col">사용여부</th>
									</tr>
								</thead>
								<tbody id="listAcc"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
							</div>
											
						</div>

		
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	
	<!-- 모달 수정 팝업 -->
		<div id="AccTitlereg" class="layerPop layerType2" style="width: 600px;"> <!-- 수정시 필요한 num 값을 넘김  -->
		
		<dl>
			<dt>
				<strong>계정과목관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>

					<tbody>
					
						<tr id="bacc_name_ro">
						<th scope="row">계정대분류명<span class="font_red">*</span></th>
							<td><select name="paccall" id="paccall" required></select>
							</td>
						</tr>
	
						<tr id="bacc_name_rd">
							<th scope="row">계정대분류명<span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="paccall_rd" id="paccall_rd" required/></td>
						</tr>
						<tr>
							<th scope="row">계정세부명 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" style="width: 150px;"
								name="dacc_name" id="dacc_name" required /></td>
						</tr>
						
						<tr id="dacc_code_rd">
							<th scope="row">세부코드 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="dacc_code" id="dacc_code" required/></td>
						</tr>
						
						<tr>
							<th scope="row">상세내용</th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="dacc_detail" id="dacc_detail"  required>
								</textarea>
						</tr>
						
						<tr id="use_yn_up">
							<th scope="row">사용여부</th>
                           		<td><select id="use_yn" name="use_yn"  >
                          		 	<option value="Y" selected = "selected">Y</option>
									<option value="N" >N</option>
                        		</select></td>
						</tr>

						<tr>
							<th scope="row">구분</th> 
							<td>
								<select id="dacc_div" name="dacc_div" style="width: 150px;" >
									<option value="" >선택</option>
									<option value="1" >지출</option>
									<option value="2" >수입</option>
							</select>
							</td>
						</tr>
						
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn" ><span>등록</span></a> 
					<a href="" class="btnType blue" id="btnUpdate" name="btn" ><span>수정</span></a>
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	
	
	
	
	
</form>

</body>
</html>
