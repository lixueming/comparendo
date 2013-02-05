function watermark(inputId,text){
  var inputBox = document.getElementById(inputId);
    if (inputBox.value.length > 0){
      if (inputBox.value == text)
      {
        inputBox.value = '';
        inputBox.className='none-watermark-color';
      }
    }
    else
    {
      inputBox.value = text;      
      inputBox.className='watermark-color';
    }
}
