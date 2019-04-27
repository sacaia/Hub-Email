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
//////////////ON CLICK "CHECKBOX"////////////////////////////
    $("#lida-naoLida").click(function(){
        if($(this).hasClass("nao-lida"))
        {
            $(this).addClass("fa-envelope-open lida");
            $(this).removeClass("fa-envelope nao-lida");
        } 
        else
        {
            if($(this).hasClass("lida"))
            {
                $(this).addClass("fa-envelope nao-lida");
                $(this).removeClass("fa-envelope-open lida");                 
            }
        }
        
    });

});