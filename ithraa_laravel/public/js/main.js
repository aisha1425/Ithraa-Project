function openwrap(i){
    let allData = document.getElementsByClassName("wrap");
    for(var j=0;j<allData.length;j++){
        if(document.getElementById("wrap" + i) != allData[j]){

            allData[j].classList.remove("visible-wrap");
            allData[j].classList.add("hidden-wrap");
        }
        
    }
    
    if(document.getElementById("wrap" + i).classList.contains("hidden-wrap")){

        document.getElementById("wrap" + i).classList.remove("hidden-wrap");
        document.getElementById("wrap" + i).classList.add("visible-wrap");
    } else {
        document.getElementById("wrap" + i).classList.add("hidden-wrap");
        document.getElementById("wrap" + i).classList.remove("visible-wrap");
    }
}