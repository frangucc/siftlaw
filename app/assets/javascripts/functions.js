$(document).ready(function() {
    
    $('.sub_nav > span').hover(
        function() {
            $(this).addClass("hover");
        },
        function() {
            $(this).removeClass("hover");
        }
    );
    
    $('.featured li').hover(
        function() {
            $(this).addClass("hover");
        },
        function() {
            $(this).removeClass("hover");
        }
    );
    
    $('.portfolio_images li.active').hover(
        function() {
            $(this).addClass("hover");
        },
        function() {
            $(this).removeClass("hover");
        }
    );
    
    $('.validate').validate({
        highlight: function(element, errorClass, validClass) {
           $(element).addClass(errorClass).removeClass(validClass);
           $(element.form).find("label[for=" + element.id + "]")
                          .addClass('label-error');
        },
        unhighlight: function(element, errorClass, validClass) {
           $(element).removeClass(errorClass).addClass(validClass);
           $(element.form).find("label[for=" + element.id + "]")
                          .removeClass('label-error');
        },
        showErrors: function(errorMap, errorList) {
            $(".error_summary").html("Your form contains "
                                           + this.numberOfInvalids() 
                                           + " errors, see details below.");
            this.defaultShowErrors();
        },
        rules: {
            email: {
                email: true
            },
            password_confirm: {
                equalTo: "#password"
            }
            
        }
    });
    
    jQuery.extend(jQuery.validator.messages, {
    required: "Required.",
    remote: "Please fix this field.",
    email: "Please enter a valid email address.",
    url: "Please enter a valid URL.",
    date: "Please enter a valid date.",
    dateISO: "Please enter a valid date (ISO).",
    number: "Please enter a valid number.",
    digits: "Please enter only digits.",
    creditcard: "Please enter a valid credit card number.",
    equalTo: "Passwords do not match.",
    accept: "Please enter a value with a valid extension.",
    maxlength: jQuery.validator.format("Please enter no more than {0} characters."),
    minlength: jQuery.validator.format("Please enter at least {0} characters."),
    rangelength: jQuery.validator.format("Please enter a value between {0} and {1} characters long."),
    range: jQuery.validator.format("Please enter a value between {0} and {1}."),
    max: jQuery.validator.format("Please enter a value less than or equal to {0}."),
    min: jQuery.validator.format("Please enter a value greater than or equal to {0}.")
    });
    
    $('#save_profile').click(function(){
        $('#create_profile_form').submit();
        return false;
    });
    
});