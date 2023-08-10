
 let url = window.location.href;
		let searchType = url.split("searchType=")[1];

		if(searchType == "PENDING"){
			document.getElementById("pending").checked = true;
		}

		if(searchType == "ACCEPTED"){
			document.getElementById("accepted").checked = true;
		}

		if(searchType == "DELIVERED"){
			document.getElementById("delivered").checked = true;
		}

		if(searchType == "REJECTED"){
			document.getElementById("rejected").checked = true;
		}

		if(searchType == "CANCELLED"){
			document.getElementById("cancelled").checked = true;
		}