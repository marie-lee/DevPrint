<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page session="true"%>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="sidebar.jsp"%>
<head>
<link rel="stylesheet" href="/resources/css/issue.css?A">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.tag-container {
	border: 1px solid #ccc;
	display: inline-block;
	padding: 5px;
	margin: 5px;
}

.tag {
	display: inline-block;
	padding: 5px;
	background-color: #007bff;
	color: #fff;
	border-radius: 5px;
	margin-right: 5px;
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="container">
		<div class="issue-wrapper">
			<div class="mt-5">
				<h1 class="mb-4">${project.projectName}이슈등록</h1>
				<form method="post" class="p-3" action="/issue/write.do"
					id="issue-form">
					<input type="hidden" name="projectId" value="${projectId}">
					<%-- <input type = "hidden" name="taskId" value = "${ taskId }"><br> --%>
					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label">프로젝트</label>
						<div class="col-sm-10">
							<input type="text" readonly class="form-control-plaintext"
								name="projectTitle" value="프로젝트">
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label">안건</label>
						<div class="col-sm-10">
							<select class="form-select" aria-label="Default select example"
								name="category">
								<option value="" selected>선택</option>
								<option value="논의">논의</option>
								<option value="개발">개발</option>
								<option value="제안">제안</option>
							</select>
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label">작성자 </label>
						<div class="col-sm-10">
							<input type="text" readonly class="form-control-plaintext"
								name="writer" value="${ sessionScope.name }">
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="title">
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label">알림</label>
						<div class="col-sm-7">
							<div id="sendingEmail-container"></div>
							<input id="sendingEmail" type="hidden" class="form-control"
								name="sendingEmail">
						</div>
						<div class="col-sm-3">
							<select id="chooseMember" class="form-select col-sm-10">
								<option value"">멤버 선택</option> 
								<c:forEach items="${memberList}" var="member">
									<option value="${member.email}">${member.userId}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2 col-form-label">내용</label>
						<div class="col-sm-10">
							<textarea type="text" class="form-control" name="content"
								style="height: 15vh"></textarea>
						</div>
					</div>
					<div>
						<button type="submit" class="btn btn-primary" style="float: right">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
	// 중복 태그 방지를 위한 Set 데이터 구조 사용
		$(document).ready(
				function() {
					$("#chooseMember").change(
							function() {
								// 선택된 옵션의 값을 <input> 요소의 현재 값에 추가합니다.
								var selectedValue = $(this).val();
								var currentInputValue = $("#sendingEmail")
										.val();
								addTag(selectedValue);
							});
					// 중복 태그 방지를 위한 Set 데이터 구조 사용
			        var tagsSet = new Set();

			        // 태그를 추가하는 함수
			        function addTag(selectedValue) {
			            var tagText = selectedValue;

			            if (tagText !== "") {
			                if (!tagsSet.has(tagText)) {
			                    var tagContainer = document.createElement("div");
			                    tagContainer.className = "tag-container";
			                    var tag = document.createElement("span");
			                    tag.className = "tag";
			                    tag.textContent = tagText;
			                    tagContainer.appendChild(tag);
			                
			                    var currentInputValue = $("#sendingEmail").val();
			                    if (currentInputValue) {
			                        // 이미 값이 있는 경우 공백을 추가한 후 선택된 값을 추가합니다.
			                        $("#sendingEmail").val(currentInputValue + "," + selectedValue);
			                    } else {
			                        // 값이 없는 경우 선택된 값을 직접 추가합니다.
			                        $("#sendingEmail").val(selectedValue);
			                    }

			                    // "X" 버튼을 추가하여 태그를 삭제
			                    var closeButton = document.createElement("span");
			                    closeButton.innerHTML = " &#10006;";
			                    closeButton.style.cursor = "pointer";
			                    closeButton.addEventListener("click", function() {
			                        tagContainer.remove();
			                        tagsSet.delete(tagText);
			                    });
			                    tag.appendChild(closeButton);

			                    var tagContainerDiv = document.getElementById("sendingEmail-container");
			                    tagContainerDiv.appendChild(tagContainer);
			                    tagsSet.add(tagText);
			                } else {
			                    alert("이미 존재하는 태그입니다.");
			                }
			            }
			        }
				});

		
	</script>
</body>
</html>