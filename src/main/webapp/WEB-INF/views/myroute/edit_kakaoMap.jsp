<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- api키와 지도를 형성하는 <div id="map">은 지도를 넣고 싶은 위치에 넣기 -->
				<script>
			
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(37.6562677764281, 127.063030448739), // 지도의 중심좌표(노원역)
			        level: 7 // 지도의 확대 레벨
			    };  
			
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			//일정에 담기 리스트 불러오기
			var route ='${editRoute}';
			var addrArr=[]; //주소 담을 배열
			var infoArr=[]; //info 담을 배열
			
			//controller에 myRoute불러오기
			<c:forEach items='${editRoute}' var='rdto'>
					var info ='${rdto.getTour_name()}'; 
					var address ='${rdto.getTour_addr()}';
					addrArr.push(address);
					infoArr.push(info);
			</c:forEach>
			
			//주소-좌표 변환 메소드
			var geocoder = new kakao.maps.services.Geocoder();

			//주소-좌표 변환
			addrArr.forEach(function(address, index) {
			    geocoder.addressSearch(address, function(result, status) {
			        if (status === kakao.maps.services.Status.OK) {
			        	//좌표 받기
			        	var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			            var lat = result[0].y;
			            var lng = result[0].x;
			            
			            //positions라는 객체에 info와 좌표 담기
			            var positions=[{
			            	content: '<div>'+infoArr[index]+'</div>',
							latlng: coords
			            }];
			            
			            //마커 찍기
			            for(var i=0; i<positions.length; i++){
					        var marker = new kakao.maps.Marker({
					            map: map,
					            position: positions[i].latlng,
					            clickable: true
					        });
				            map.setCenter(coords);
					      
			            var infowindow = new kakao.maps.InfoWindow({
				            content: positions[i].content
				        });
				        kakao.maps.event.addListener(marker, 'click', marker_click(map, marker, infowindow));
					
			            };
			     		   }
			 		   });
					});
						
			var linePath = [];

			var polyline = new kakao.maps.Polyline({
			    path: linePath,
			    strokeWeight: 3,
			    strokeOpacity: 1,
			    strokeColor: 'red',
			    strokeStyle: 'solid'
			});

			const addressSearch = address => {
			    return new Promise((resolve, reject) => {
			        geocoder.addressSearch(address, function(result, status) {
			            if (status === kakao.maps.services.Status.OK) {
			                resolve(result);
			            } else {
			                reject(status);
			            }
			        });
			    });
			};

			(async () => {
			    try {
			        for(var address of addrArr) {
			            const result = await addressSearch(address);
			            setPolyLine(result);
			        }
			    } catch (e) {
			        console.log(e);
			    }
			})();

			function setPolyLine(result) {
			    const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			    linePath.push(coords);
			    polyline.setPath(linePath);

			    if(!polyline.getMap()) {
			        polyline.setMap(map);
			    }
			}
					 	
				//마커를 누르면 장소명이 뜸(이 부분은 추후에 디테일하게 바꿔야함..)
		        function marker_click(map, marker, infowindow){ 	 
		        	return function() {
		        	infowindow.open(map, marker);
		        			};
		        	}  	  
					      
				
				</script>