// $(document).ready(function(){
//  console.log(“jQuery ready!“);
// });

$(document).ready(function(){
  $(".questionupvote").on("submit", function(event){
    event.preventDefault();
    form_inputs = $(this).serialize()
    $.ajax({
      url: $(this).attr('action'),
      method: "post",
      data: form_inputs,
      dataType: "JSON",
      success: function(jagenwarning){
      $("#abc"+jagenwarning[1]).html(jagenwarning[0])
      }
    })
  })
  $(".questiondownvote").on("submit",function(event){
    event.preventDefault();
    $.ajax({
      url: $(this).attr('action'),
      method: "post",
      dataType: "JSON",
      success: function(jasonwarning){
        $("#abc"+jasonwarning[1]).html(jasonwarning[0])
      }
    })
  })

})
