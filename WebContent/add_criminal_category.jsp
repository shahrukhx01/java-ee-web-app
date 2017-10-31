<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="header.jsp"></c:import>

<body>


<div class="modal" id="addCat">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Add Criminal Category


                </h4>


            </div>
            <div class="modal-body">
                <div class="container" id="chatbox">
                    <div class="row pad-top pad-bottom">
<br>

                        <div class=" col-lg-6 col-md-6 col-sm-6">
                            <div class="chat-box-div">

                                <div class="chat-box-footer">
                                   <form action="${pageContext.request.contextPath}/AddCriminalCategory" method="post">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="category" placeholder="Enter Category Name...">
                                        <input type="hidden" id="hidden_id" name="hidden_id"  >
                            <span class="input-group-btn">
                                <button class="btn btn-info" type="submit">Add </button>
                            </span>
                                    </div>
                                    </form>
                                </div>

                            </div>

                        </div>

                    </div>
                </div>


            </div>
        </div>
    </div>
</div>


</body>

</html>
<script>
    $('#openBtn').click(function () {
        $('#addCat').modal({show: true})
    });

</script>

