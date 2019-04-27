//////////////ON CLICK "CHECKBOX"////////////////////////////
$(document).ready(function(){
    $("#checkboxAll").click(function(){
        if($(this).hasClass("not-checked"))
        {
            $(this).addClass("fas fa-check-square checked");
            $(this).removeClass("far fa-square not-checked");
        } 
        else
        {
            if($(this).hasClass("checked"))
            {
                $(this).addClass("far fa-square not-checked");
                $(this).removeClass("fas fa-check-square checked");                 
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
//////////////////////////////////////////////////////////
});