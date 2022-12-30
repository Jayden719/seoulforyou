<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="navBar.jsp" %>
<!DOCTYPE html>
<html lang="en">

<title>관리자 페이지</title>
    <!-- 대시보드 항목입니다 -->
    <div class="container-fluid px-4">
        <h1 class="mt-4">대시보드</h1>
        <div class="row">
			<div class="col-xl-6">
				<div class="card mb-4">
					<div class="card-header">
						<i class="fas fa-chart-area me-1"></i>
                           	회원가입 추이
					</div>
					<div class="card-body">
						<canvas id="memberChart" width="100%" height="50"></canvas>
					</div>
					<div class="card-footer small text-muted"></div>
				</div>
            </div>
			<div class="col-xl-6">
				<div class="card mb-4">
					<div class="card-header">
						<i class="fas fa-chart-bar me-1"></i>
                         	주간 리뷰 수
					</div>
					<div class="card-body">
						<canvas id="reviewChart" width="100%" height="50"></canvas>
					</div>
					<div class="card-footer small text-muted"></div>
				</div>
			</div>
		</div>
		</div>
          
     		<div class="container-fluid px-4">
                        <h1 class="mt-4">회원목록</h1><br>
                        <div class="card mb-4"></div>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                DataTable Member
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>이름</th>
                                            <th>아이디</th>
                                            <th>비밀번호</th>
                                            <th>이메일</th>
                                            <th>전화번호</th>
                                        </tr>
                                    </thead>
                                     
                                     <c:if test= "${empty listOfMember}">
                                     	<tr>
                                     	<td colspan="6">등록된 회원이 없습니다</td>
                                     	</tr>
                                     </c:if>
                                      <tfoot>
                                        <tr>
                                            <th>번호</th>
                                            <th>이름</th>
                                            <th>아이디</th>
                                            <th>비밀번호</th>
                                            <th>이메일</th>
                                            <th>전화번호</th>
                                        </tr>
                                    </tfoot>
                                     <tbody>
                                         <c:forEach var="dto" items= "${listOfMember}">	
                                        <tr>
                                            <td>${dto.member_no}</td>
                                            <td>${dto.member_name}</td>
                                            <td>${dto.member_id}</td>
                                            <td>${dto.member_passwd}</td>
                                            <td>${dto.member_email}</td>
                                            <td>${dto.member_hp}</td>
                                        </tr>
                                        </c:forEach> 
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
		            
		    </main>
			                <footer class="py-4 bg-light mt-auto">
			                    <div class="container-fluid px-4">
			                        <div class="d-flex align-items-center justify-content-between small">
			                            <div class="text-muted">Copyright &copy; Your Website 2022</div>
			                            <div>
			                                <a href="#">Privacy Policy</a>
			                                &middot;
			                                <a href="#">Terms &amp; Conditions</a>
				                            </div>
				                        </div>
				                    </div>
				                </footer>
				            </div>
				        </div>
				        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
				        <script src="resources/js/scripts.js"></script>
				        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
				        <script src="resources/demo/chart-area-demo.js"></script>
				        <script src="resources/demo/chart-bar-demo.js"></script>
				        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
				        <script src="resources/js/datatables-simple-demo.js"></script>
    
    				<!-- 문의내용 검색결과 모달 -->
    				<div class="modal fade"  id="qnaFind" >
           		    <div class="modal-dialog">
			 		<div class="modal-content ">
			  		<div class="modal-header justify-content-center">
			  		<h1 class="h3 fw-normal">검색한 문의글</h1> 
			  		 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			   		</div>
			   		<div class="modal-body d-flex justify-content-center" style="width:500px; height:400px">
			  		<textarea id="qnaFind2" rows="10px" cols="200px"  placeholder="검색한 문의글이 없습니다" class="d-flex justify-content-center"></textarea>
					</div>
					<div class="modal-footer">
					</div>
					</div>
					</div>
					</div>
    					
    					 <!-- 관리자등록 모달 내용 --> 	
                 		<div class="modal fade" id="staticBackdrop" data-bs-backdrop="true" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                      	<div class="modal-dialog">
                      	<div class="modal-content">
     				  	<div class="modal-header bg-light">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel"><strong>관리자 등록</strong></h1>  <!-- fs는 폰트 크기입니다 -->
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>  <!-- 창의 취소 버튼입니다 -->
      					</div>
	    				<div class="modal-body" style="height:600px">
	  					<!-- 관리자 등록 모달 form태그 시작 -->
	  					<form name="f" id="f" action="admin_input_ok.do" method="post" enctype="multipart/form-data">

	                   <div class="form-floating mb-5">
	                   <input class="form-control" id="admin_aid" name="admin_id" type="text" status="" />
	                   <label for="admin_aid">아이디</label>
	                   <input type="button" class="btn btn-secondary" onclick="checkAid()" value="중복확인" style="float:right">                   
	                   </div>
	                  
	                   
	                   <div class="form-floating mt-3 mb-3">
	                   <input class="form-control" id="admin_name" name="admin_name" type="text"/>
	                   <label for="admin_name">성함</label>
	              		</div>
	              		
	              	    <div class="form-floating mb-3">
	              	    <input class="form-control" id="admin_email" name="admin_email" type="email"  />
	                   	<label for="admin_email">이메일 주소</label>
	              		</div>
	              		
		                <div class="form-floating mb-3">
	                   <input class="form-control" id="admin_passwd" name="admin_passwd" type="password"/>
	                   <label for="admin_passwd">비밀번호</label>
	                   </div>
		                   
	                   <div class="form-floating mb-3">
	                   <input class="form-control" id="admin_passwd_confirm" name="admin_passwd_confirm" type="password"  
	                    onkeyup="passConfirm()"/>
	                   <label for="admin_passwd_confirm">비밀번호 확인</label>
	                   </div>
	                   
	                   <div id="confirmMsg"></div>
	                   
              		<!-- 파일 업로드 -->
					<table class="form-floating mb-3 mb-md-1" >
					<tbody>
					<tr>
					<th>프로필 이미지 첨부 </th>
						<tr>
						<td>
					<input type="file" name="admin_profileImg" id="admin_profileImg" accept="image/*">
					<input type="hidden" name="admin_id" id="admin_id" value="${sessionScope.adto.admin_id}">
					<input type="reset" value="취소" >
                     		</td>
                     		</tr>	
                     		</tbody>
                     		</table>
                     		
	               <div class="modal-footer">
				   <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				   <input type="button" onclick="submitForm()" class="btn btn-primary" value="등록">
			  	   </div>
					</form>
					</div>
    				</div>
    				</div>
				   </div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    	//지난주, 이번주 회원가입 인원수 차트
    	const memberCtx = document.getElementById('memberChart');
    	
    	const WEEKS = [
    		  '지난 월',
    		  '지난 화',
    		  '지난 수',
    		  '지난 목',
    		  '지난 금',
    		  '지난 토',
    		  '지난 일',
    		  '월',
    		  '화',
    		  '수',
    		  '목',
    		  '금',
    		  '토',
    		  '일'
    		];

    	function weeks(config) {
    		  var cfg = config || {};
    		  var count = cfg.count || 14;
    		  var section = cfg.section;
    		  var values = [];
    		  var i, value;

    		  for (i = 0; i < count; ++i) {
    		    value = WEEKS[Math.ceil(i) % 14];
    		    values.push(value.substring(0, section));
    		  }

    		  return values;
    		}
    	
    	const labels = weeks({count: 14});
    	
    	var memberChart = new Chart(memberCtx, {
		    type: 'line',
		    data: {
		    	labels: labels,
		    	  datasets: [{
		    	    label: '가입자 수',
		    	    data: [10, 50, 100, 20, 30, 10, 20, 10, 50, 100, 20, 30, 10, 20],
		    	    fill: false,
		    	    borderColor: 'rgb(75, 192, 192)',
		    	    tension: 0.1
		    	  }
		    	  ]
		    },options:{
 		  		scales:{
 		  			y: {
 		  				suggestedMin: 10
 		  			}
 		  		},
		    	ticks:{
		    		stepSize: 1
		    		}
		    }
		  });
    	
    	
    	var datas = []; // 데이터 담을 배열
     <c:forEach items='${memberChartValue}' var='num'>
      var num = '${num}'; 
      datas.push(num);
     </c:forEach>
  	// 배열 거꾸로
     const reverse = datas.reverse();
      
 
 var dataset = memberChart.data.datasets;
 for(var i=0; i<dataset.length; i++){
	//데이터 갯수 만큼 반복
	var data = dataset[i].data;
	for(var j=0 ; j < data.length ; j++){
		data[j] = datas[j];
	}
}

memberChart.update();
     	
</script>

 <script type="text/javascript">
     function passConfirm(){
    var admin_passwd = document.getElementById('admin_passwd');
    var admin_passwd_confirm = document.getElementById('admin_passwd_confirm');
    var confrimMsg = document.getElementById('confirmMsg');
    var correctColor = "blue";
    var wrongColor ="red";
     	
    if(admin_passwd.value == admin_passwd_confirm.value){
 	   confirmMsg.style.color = correctColor;
 	   confirmMsg.innerHTML ="비밀번호 일치";
    }else{
 	  	confirmMsg.style.color = wrongColor;
confirmMsg.innerHTML ="비밀번호 불일치";
    }
     }
     </script>
 
 <script>
     	//이번주 리뷰수 차트
     	const reviewCtx = document.getElementById('reviewChart');
     	var reviewChart = new Chart(reviewCtx, {
 		    type: 'bar',
 		    data: {
 		    	labels: [
 		    	    '월',
 		    	    '화',
 		    	    '수',
 		    	    '목',
 		    	    '금',
 		    	    '토',
 		    	    '일'
 		    	  ],
 		    	  datasets: [{
 		    	    label: '리뷰 수',
 		    	    data: [0, 0, 0, 0, 0, 0, 0],
 		    	    borderWidth: 1
 		    	  }
 		    	  ]
 		    },
 		  	 options:{
 		  		scales:{
 		  			y: {
 		  				suggestedMin: 10
 		  			}
 		  		},
		    	ticks:{
		    		stepSize: 1
		    		}
		    }
 		  });
     	
     	var datas = []; // 일별 리뷰갯수 담을 배열
      <c:forEach items='${reviewChartValue}' var='num'>
      var num ='${num}';
      datas.push(num);
   	</c:forEach>
 
 var dataset = reviewChart.data.datasets;

 for(var i=0; i<dataset.length; i++){
	//데이터 갯수 만큼 반복
	var data = dataset[i].data;
	for(var j=0 ; j < data.length ; j++){
		data[j] = datas[j];
	}
}

reviewChart.update();
</script>

<script type="text/javascript">
function checkAid(){
	let status = $('#admin_aid').attr('status');
	let adminId = $('#admin_aid').val();
	$('.checkIdSpan').remove();
	
	if(adminId == ""){
		$('#admin_aid').after("<span class='checkIdSpan' style='color:lightgray'>아이디 중복상태를 확인해주세요</span>");
		$('#admin_aid').focus();
		return
	}
	$.ajax({
		url : 'check_adminId.do',
		type : 'post',
		async : true,
		data : {admin_id : adminId},
		success : function(data){
			if(data.holy>0){
				$('#admin_aid').attr('status', 'no');
				$('#admin_aid').after("<span class='checkIdSpan' style='color:red'>사용할수  없는 아이디 입니다</span>");
				$('#admin_aid').focus();
			}else{
				$('#admin_aid').attr('status', 'yes');
				$('#admin_aid').after("<span class='checkIdSpan' style='color:blue'>사용가능한 아이디입니다</span>");
			}
		},
		error: function(e){
			alert("에러입니다");
		}
	});
}

	function submitForm(){
		let status = $('#admin_aid').attr('status');
		
		if(status == ""){
			alert('중복체크를 해주십시오');
			$('#admin_aid').focus();
		}else if(status == "no"){
			alert('아이디를 바꿔주십시오');
			$('#admin_aid').focus();
		}else{
			$('#f').submit();
		}
	}
</script>


<script>
	function qnaFind(){
		var key_word = $('#qna_find').val();
		
		$.ajax({
		url: 'qna_find.do',
		method: 'post',
		data: {
			key_word: key_word	
		},
		success: function(data){
			var qnaArr = data.qna;
			$("#qnaFind2").text(qnaArr)
		},
		error : function(){
		}
		})
	}
		</script>   

<script>
function adminLogout(){
	location.href="adminLogout.do";
}
</script>


</body>
</html>
