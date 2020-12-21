<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<jsp:useBean   id="today"  class="java.util.Date" scope="session"/> 
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<!-- https://code.jquery.com/       jQuery Core 3.5.1 - uncompressed -->

<!-- start banner Area -->
<section class="banner-area relative" id="home">
	<div class="overlay overlay-bg"></div>
	<div class="container">
		<div class="row d-flex align-items-center justify-content-center">
			<div class="about-content col-lg-12">
				<h1 class="text-white">確認訂單</h1>
				<p class="text-white link-nav">
					<a href="index.html">首頁</a>
				    <span class="lnr lnr-arrow-right"></span>
					<a href="<c:url value='/18/cSelectAllFront.ctrl' />">課程總覽</a>
					<span class="lnr lnr-arrow-right"></span>
					<a href="<c:url value='/18/toCoCart.ctrl' />">購物車</a>
					<span class="lnr lnr-arrow-right"></span>
					<a href="<c:url value='/18/SubmitCartCo.ctrl' />">訂單</a>
				</p>
			</div>
		</div>
	</div>
</section>
<!-- End banner Area -->

<div class="container" style="font-size: 18px">
<h3 style="text-align: center;margin-top: 80px;">訂單詳細</h3>
<FORM >
    <table>
        <tr>
        <!-- name:收到的     id:識別名稱     value:預設填入的值 -->
            <th><label>購買人姓名：</label>
                <input type="text" name="Name" id='coName' value="${mb.realName}">
            </th>
            <th><label>聯絡電話：</label>
                <input type="text" name="Phone" id='coPhone' value="${mb.tel}">
            </th>
        </tr>
        <tr><th>下單日期：<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" /></th></tr>
        <tr>
            <td colspan='3' >E-mail：<input id='email' name="email" type="text" value="${mb.email}" style="width: 500px;" ></td>
        </tr>    
        <tr>
            <td colspan='3' >地址：<input name="customerAddress" id='coCustomerAddress' type="text" value="${mb.address}" style="width: 500px;" ></td>
            
        </tr>
        <tr>
            <td colspan='3'>意見(選填)：<input name="coComment" id='coComment' type="text" style="width: 500px; height:100px "></td>
            
        </tr>
        
    </table>

    <table>
        <tr>
            <th>課程名稱</th>
            <th>課程價格</th>
            <th>數量</th>
            <th>小計</th>
        </tr>
        <c:forEach varStatus="vs" var="orderCo" items="${ccc.cartCo}"> <!-- 兩層 ccc.cartCo 在 CourseControllerF #43 #71 -->
        <tr>
            <td>${orderCo.value.coTitle}</td>
            <td>${orderCo.value.coPrice} 元</td>
            <td>${orderCo.value.coNum}</td>
            <td>${orderCo.value.coPrice * orderCo.value.coNum} 元</td>
        </tr>
        </c:forEach>
        <tr>
        
        <td colspan="4">總計： ${ccc.total} 元</td>
    </tr>
    </table>
   <input type="hidden" name="finalDecision"  value="">   
   <div class="container" style="text-align: center;margin-top: 30px;">
   <input type="button" name="OrderBtn"  value="送出本訂單" onclick="reconfirmOrderCo();">
<!--    <input type="button" name="CancelBtn" value="取消本訂單" onclick="cancelOrderCo();"> -->
<!-- 			↑原本的彈出視窗  ；  SweetAlert↓   -->   
   <button class="genric-btn danger circle" onclick="delSAFALL()">取消本訂單</button>
   </div>
    </FORM>
	</div>
   
   
   <!-- id需與下方script相同 -->
   <div><button id="OrderDetailComment" >一鍵輸入買家意見</button></div>
   <div><button id="OrderDetailMail" >一鍵輸入測試用信箱</button></div>
   

<script type="text/javascript">   
function delSAFALL(){
	swal("您確定要刪除所有已選擇的課程嗎？","", "warning",{
	    buttons: {
	      danger: {
	          text: "是"
	        },
	      "否": true,
	    },
	  })

		.then((value2) => {
		switch (value2) {
		case "danger":
	    	swal("成功取消訂單","", "success")
	    	setTimeout(function(){window.location="<c:url value='/18/cdeleteCartListAll.ctrl'/>" ; },2000);
	        break;
	      case "不是":
	        swal("放棄修改","", "info");
	        break;
	      default:
	    	  swal("未取消訂單","", "info");
	        break;
		}
		});
};   
   
   
   
</script>   
<script>
<!-- $("最上方的id:識別名稱") -->
$("#OrderDetailComment").click(function(){
	$("#coComment").val("已報名，感謝。");
})

$("#OrderDetailMail").click(function(){
	$("#email").val("aaartgroup4@gmail.com");
})

// <!-- 使用var宣告變數，可用範圍以function為界 -->
function reconfirmOrderCo(){
	if (confirm("您確定要送出 ? ") ) {
		document.forms[0].action="<c:url value='/18/ProcessOrderCo.ctrl'/>";
		document.forms[0].method="POST";
		document.forms[0].submit();
		return;
	} else {
		return;
	}
}

// function cancelOrderCo() {
// 	if (confirm("您確定要取消 ? ") ) {
// 		// 接收此資料的Servlet會使用 finalDecision 參數的值
// 		document.forms[0].action="<c:url value='/18/deleteCartList.ctrl' />";
// 		document.forms[0].method="POST";
// 		document.forms[0].submit();
// 		return;
// 	} else {
// 		return;
// 	}
// }

</script>