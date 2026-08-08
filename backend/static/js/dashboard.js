// =====================================
// Live Date & Time
// =====================================

function updateDateTime() {

    const now = new Date();

    document.getElementById("currentDate").innerHTML =
        now.toLocaleDateString("en-IN", {
            day: "2-digit",
            month: "long",
            year: "numeric"
        });

    document.getElementById("currentTime").innerHTML =
        now.toLocaleTimeString("en-IN");
}

setInterval(updateDateTime, 1000);
updateDateTime();


// =====================================
// Dark Mode
// =====================================

const themeButton = document.getElementById("themeToggle");

if (themeButton) {

    themeButton.addEventListener("click", () => {

        document.body.classList.toggle("dark-mode");

    });

}


// =====================================
// Search Table
// =====================================

function searchTable() {

    const input = document.getElementById("searchInput");

    const filter = input.value.toUpperCase();

    const table = document.getElementById("historyTable");

    const tr = table.getElementsByTagName("tr");

    for (let i = 1; i < tr.length; i++) {

        let found = false;

        const td = tr[i].getElementsByTagName("td");

        for (let j = 0; j < td.length; j++) {

            if (td[j]) {

                if (td[j].innerHTML.toUpperCase().indexOf(filter) > -1) {

                    found = true;

                }

            }

        }

        tr[i].style.display = found ? "" : "none";

    }

}


// =====================================
// Delete History
// =====================================

function deleteHistory() {

    if (!confirm("Delete all session history?")) {

        return;

    }

    fetch("/history", {

        method: "DELETE"

    })

    .then(res => res.json())

    .then(data => {

        alert(data.message);

        location.reload();

    });

}



// =====================================
// Export Buttons
// =====================================

const excelBtn =
document.getElementById("exportExcel");

if(excelBtn){

excelBtn.onclick=function(){

window.location.href="/export/excel";

}

}

const csvBtn =
document.getElementById("exportCSV");

if(csvBtn){

csvBtn.onclick=function(){

window.location.href="/export/csv";

}

}


// =====================================
// Auto Refresh
// =====================================

setInterval(function(){

location.reload();

},30000);