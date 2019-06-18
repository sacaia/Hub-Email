$(document).ready(function(){
//////////////ON CLICK "CHECKBOX"////////////////////////////
    $("#checkboxAll").click(function(){
        if($(this).hasClass("not-checked"))
        {
            $(this).addClass("fas fa-check-square checked");
            $(this).removeClass("far fa-square not-checked");
            
            $('[class~=checkbox][class~=fa-square]').addClass("fas fa-check-square");
            $('[class~=checkbox][class~=fa-square]').removeClass("far fa-square");
            $('[class~=email]').addClass("active");
        } 
        else
        {
            if($(this).hasClass("checked"))
            {
                $(this).addClass("far fa-square not-checked");
                $(this).removeClass("fas fa-check-square checked");     
                
                $('[class~=checkbox][class~=fa-check-square]').addClass("far fa-square");
                $('[class~=checkbox][class~=fa-check-square]').removeClass("fas fa-check-square");
                $('[class~=email]').removeClass("active");
            }
        }
    });
//////////////ON HOVER "CHECKBOX"////////////////////////////
    /*
    $("#checkboxAll").hover(function(){
        if($(this).hasClass("not-checked"))
        {
            $(this).addClass("fas fa-check-square checked");
            $(this).removeClass("far fa-square not-checked");
        } 
    },
    function(){
        if($(this).hasClass("checked"))
            {
                $(this).addClass("far fa-square not-checked not-checked");
                $(this).removeClass("fas fa-check-square checked");                 
            }
    }); 
    */
//////////////ON ENTER "CHECKBOX"////////////////////////////
    $("#checkboxAll").on("keypress", function (e) {
        if(e.which === 13){
            
        //Disable checkbox to prevent multiple submit
        $(this).attr("disabled", "disabled");

        if($(this).hasClass("not-checked"))
        {
            $(".not-checked").addClass("checked");
            $(".not-checked").removeClass("far fa-square not-checked");
            $(".checked").addClass("fas fa-check-square");
        } 
        else 
        {
            if($(this).hasClass("checked"))
            {
                $(".checked").addClass("not-checked");
                $(".checked").removeClass("fas fa-check-square checked");
                $(".not-checked").addClass("far fa-square not-checked");                   
            }
        }

        //Enable the checkbox again if needed.
        $(this).removeAttr("disabled");
        }
    });
//////////////ON CLICK LIDA/NAO-LIDA////////////////////////////
    $("#lida-naoLida").click(function(){
        if($(this).hasClass("nao-lida"))
        {
            $(this).addClass("fa-envelope-open lida");
            $(this).removeClass("fa-envelope nao-lida");
            $(this).attr({
                    "data-original-title" : "Marcar como não lida"
                });
        } 
        else
        {
            if($(this).hasClass("lida"))
            {
                $(this).addClass("fa-envelope nao-lida");
                $(this).removeClass("fa-envelope-open lida");
                $(this).attr({
                    "data-original-title" : "Marcar como lida"
                });
            }
        }  
        // Ver se da pra tirar o foco e voltar pra resetar o tooltip //
    });
//////////////ON CLICK PAG-PROX////////////////////////////
    $("#pag-prox").click(function(){
        if($("#pag3").hasClass("bg-selected"))
        {
            return;
        }
        if($("#pag2").hasClass("bg-selected"))
        {
            $("#pag2").removeClass("bg-selected");
            $("#pag3").addClass("bg-selected");
            $("#pag-prox-container").addClass("disabled");
            return;
        }
        if($("#pag1").hasClass("bg-selected"))
        {
            $("#pag1").removeClass("bg-selected");
            $("#pag2").addClass("bg-selected");
            $("#pag-ant-container").removeClass("disabled");
            return;
        }
    });
//////////////ON CLICK PAG-ANT////////////////////////////
    $("#pag-ant").click(function(){
        if($("#pag1").hasClass("bg-selected"))
        {
            return;
        }
        if($("#pag2").hasClass("bg-selected"))
        {
            $("#pag2").removeClass("bg-selected");
            $("#pag1").addClass("bg-selected");
            $("#pag-ant-container").addClass("disabled");
            return;
        }
        if($("#pag3").hasClass("bg-selected"))
        {
            $("#pag3").removeClass("bg-selected");
            $("#pag2").addClass("bg-selected");
            $("#pag-prox-container").removeClass("disabled");
            return;
        }
    });
/////////////////ON CLICK PAG1////////////////////////////
    $("#pag1").click(function(){
        if($(this).hasClass("bg-selected"))
        {
            return;
        }
        if($("#pag2").hasClass("bg-selected"))
        {
            $("#pag2").removeClass("bg-selected");
            $(this).addClass("bg-selected");
            $("#pag-ant-container").addClass("disabled");
            return;
        }
        if($("#pag3").hasClass("bg-selected"))
        {
            $("#pag3").removeClass("bg-selected");
            $(this).addClass("bg-selected");
            $("#pag-ant-container").addClass("disabled");
            $("#pag-prox-container").removeClass("disabled");
            return;
        }
    });
/////////////////ON CLICK PAG2////////////////////////////
    $("#pag2").click(function(){
        if($(this).hasClass("bg-selected"))
        {
            return;
        }
        if($("#pag1").hasClass("bg-selected"))
        {
            $("#pag1").removeClass("bg-selected");
            $(this).addClass("bg-selected");
            $("#pag-ant-container").removeClass("disabled");
            return;
        }
        if($("#pag3").hasClass("bg-selected"))
        {
            $("#pag3").removeClass("bg-selected");
            $(this).addClass("bg-selected");
            $("#pag-prox-container").removeClass("disabled");
            return;
        }
    })
/////////////////ON CLICK PAG3////////////////////////////
    $("#pag3").click(function(){
        if($(this).hasClass("bg-selected"))
        {
            return;
        }
        if($("#pag1").hasClass("bg-selected"))
        {
            $("#pag1").removeClass("bg-selected");
            $(this).addClass("bg-selected");
            $("#pag-prox-container").addClass("disabled");
            $("#pag-ant-container").removeClass("disabled");
            return;
        }
        if($("#pag2").hasClass("bg-selected"))
        {
            $("#pag2").removeClass("bg-selected");
            $(this).addClass("bg-selected");
            $("#pag-prox-container").addClass("disabled");
            return;
        }
    });
/////////////////ON CLICK PASTA1//////////////////////////
    /*$("#pasta1").click(function(){
        if($(this).hasClass("fechada"))
        {
            $(this).removeClass("fechada");
            $(this).addClass("aberta");
            $("#icon-pasta1").removeClass("fa-folder");
            $("#icon-pasta1").addClass("fa-folder-open");
        } 
        else
        {
            if($(this).hasClass("aberta"))
            {
                $(this).removeClass("aberta");
                $(this).addClass("fechada");
                $("#icon-pasta1").removeClass("fa-folder-open");
                $("#icon-pasta1").addClass("fa-folder");             
            }
        }
    });*/
/////////////////ON CLICK CONTA1////////////////////////////
    /*$("#conta1").click(function(){
        if($(this).hasClass("active"))
        {
            return;
        }
        if($("#conta2").hasClass("active"))
        {
            $("#conta2").removeClass("active");
            $(this).addClass("active");
            return;
        }
    });
/////////////////ON CLICK CONTA2////////////////////////////
    $("#conta2").click(function(){
        if($(this).hasClass("active"))
        {
            return;
        }
        if($("#conta1").hasClass("active"))
        {
            $("#conta1").removeClass("active");
            $(this).addClass("active");
            return;
        }
    });*/
/////////////////ON CLICK CONTA////////////////////////////
    $(function () {
        $('[class!="active"][class~="list-group-item"][class~="conta"]').click(function () {
            $('[class~="active"]').removeClass("active");
            $(this).addClass("active");
            
            document.getElementById('body').innerHTML = document.getElementById('body').innerHTML + "<form id='new-form-folder-aux' method='post' action='Index.jsp'> <input class='form-control ml-4 mr-2' name='selectedEmail' type='hidden' value='" +
            $(this).attr("value") + "'></form>";
            
            document.getElementById("new-form-folder-aux").submit();
        });
    });
/////////////////ON CLICK DIVISÓRIA////////////////////////////
    $(function () {
        $('[class~="titulo-divisoria"]').click(function () {
            if($(this).hasClass("collapsed"))
            {
                $(this).find("i").removeClass("fa-caret-right");
                $(this).find("i").addClass("fa-caret-down");
            }
            else
            {
                $(this).find("i").removeClass("fa-caret-down");
                $(this).find("i").addClass("fa-caret-right");
            }
        });
    });
/////////////////ON CLICK CHECKBOX////////////////////////////
    /*$(function () {
        $('[class~="checkbox"]').click(function () {
            if($(this).hasClass("fa-square"))
            {
                $(this).removeClass("far fa-square");
                $(this).addClass("fas fa-check-square");
            }
            else
            {
                $(this).removeClass("fas fa-check-square");
                $(this).addClass("far fa-square");
            }
        });
    });*/
/////////////////ON CLICK CHECKBOX+EMAIL////////////////////////////
    $(function () {
        $('[class~="checkbox"]').click(function () {
            if($(this).closest(".email").hasClass("active"))
            {
            	value = $("#deletaveis").attr("value");
                id = $(this).closest("li").find("div").attr("id");
                index = id.slice(id.indexOf("-")+1, id.length);
                $("#deletaveis").attr("value", value.replace(index + "/", ""));
                value = $("#selecionados").attr("value");
                $(".emailPasta").attr("value", "");
                $(this).closest(".email").removeClass("active");
                $(this).removeClass("fas fa-check-square");
                $(this).addClass("far fa-square");
                var allChecked = true;
                $(".email").each(function() {
                    allChecked = (allChecked && $(this).closest(".email").hasClass("active"));
                });
                    if(!allChecked)
                    {
                        $("#checkboxAll").addClass("far fa-square not-checked");
                        $("#checkboxAll").removeClass("fas fa-check-square checked");
                    }
            }
            else
            {
                value = $("#deletaveis").attr("value");
                id = $(this).closest("li").find("div").attr("id");
                index = id.slice(id.indexOf("-")+1, id.length);
                $("#deletaveis").attr("value", value + index + "/");
                value = $("#selecionados").attr("value");
                $("#selecionados").attr("value", value + index + "/");
                $(this).closest(".email").addClass("active");
                $(this).removeClass("far fa-square");
                $(this).addClass("fas fa-check-square");
                var allChecked = true;
                $(".email").each(function() {
                    allChecked = (allChecked && $(this).closest(".email").hasClass("active"));
                });
                    if(allChecked)
                    {
                        $("#checkboxAll").addClass("fas fa-check-square checked");
                        $("#checkboxAll").removeClass("far fa-square not-checked");
                    }
            }
        });
    });
/////////////////ON CLICK PASTA////////////////////////////
    $(function () {
        $(".pasta").click(function () {
            if(!($(this).hasClass("active")))
            {
                $(".pasta").each(function() {
                    $(this).removeClass("active");
                    $(this).find("i").removeClass("fa-folder-open");
                    $(this).find("i").addClass("fa-folder");                    
                });
                
                /*if($(this).find("i").hasClass("fa-inbox"))
                {
                    $(this).addClass("active");
                    return;
                }*/
                
                $(this).addClass("active");
                /*$(this).find("i").removeClass("fa-folder");
                $(this).find("i").addClass("fa-folder-open");*/
                
                if($(this).attr("aria-expanded") == "true")
                {
                    $(this).find("i").addClass("fa-folder-open");
                    $(this).find("i").removeClass("fa-folder");
                }
              //document.getElementById('form-folder-' + $(this).find("div").html()).submit();
                document.getElementById('body').innerHTML = document.getElementById('body').innerHTML + "<form id='new-form-folder-aux' method='post' action='Index.jsp'> <input class='form-control ml-4 mr-2' name='selectedFolder' type='hidden' value='" +
                $(this).find("div").html() + "'></form>";
                
                document.getElementById("new-form-folder-aux").submit();
            }
            else
            {
            	
                /*if($(this).find("i").hasClass("fa-inbox"))
                {
                    $(this).removeClass("active");
                    return;
                }
                if($(this).attr("aria-expanded") == "true")
                {
                    //alert("a");
                    $(this).find("i").removeClass("fa-folder");
                    $(this).find("i").addClass("fa-folder-open");
                    return;
                }
                $(this).removeClass("active");
                $(this).find("i").addClass("fa-folder");
                $(this).find("i").removeClass("fa-folder-open");*/
            }
        });
    });
//funcao de clickar nas paginarions
    $(function () {
        $(".myPagination").click(function () {
            if(!($(this).hasClass("active")))
            {
                
                document.getElementById('body').innerHTML = document.getElementById('body').innerHTML + "<form id='new-form-pagination-aux' method='post' action='Index.jsp'> <input class='form-control ml-4 mr-2' name='selectedPagination' type='hidden' value='" +
                $(this).html() + "'></form>";
                
                document.getElementById("new-form-pagination-aux").submit();
            }
            else
            {
            	
                /*if($(this).find("i").hasClass("fa-inbox"))
                {
                    $(this).removeClass("active");
                    return;
                }
                if($(this).attr("aria-expanded") == "true")
                {
                    //alert("a");
                    $(this).find("i").removeClass("fa-folder");
                    $(this).find("i").addClass("fa-folder-open");
                    return;
                }
                $(this).removeClass("active");
                $(this).find("i").addClass("fa-folder");
                $(this).find("i").removeClass("fa-folder-open");*/
            }
        });
    });
/////////////////ON CHANGE FILE////////////////////////////
    /*$(function () {
    	$('input[type=file]').change(function () {
    		file = input.files[0];
            fr = new FileReader();
            fr.readAsDataURL(file);

            var blob = new Blob([file], { type: "application/pdf" });

            var objectURL = window.URL.createObjectURL(blob);
            console.log(objectURL);

            var link = document.createElement('a');
            link.href = objectURL;
            link.download = "myFileName.pdf";
            link.click();
    	});
    });*/
    
//////////////////////////////////////////////////////////
});