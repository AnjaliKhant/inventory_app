const inventoryData = [];  // data structure to hold inventory data
const tableBody = document.getElementById('inventoryTableBody');

const socket = new WebSocket('ws://localhost:8081/');

socket.onmessage = (event) => {
    const data = JSON.parse(event.data);
    
    // Update inventory
    const existingItem = inventoryData.find(item => item.store === data.store && item.model === data.model);
    if (existingItem) {
        existingItem.updated = 'Yes';
        existingItem.inventory = data.inventory;
    } else {
        data.updated = 'No';
        inventoryData.push(data);
    }

    // Render the updated inventory
    renderInventory();
};

function renderInventory() {
    tableBody.innerHTML = '';  // Clear the existing table rows
    let index = 0;
    let inventoryStatus;

    inventoryData.forEach(data => {
        // Create a new row
        const newRow = document.createElement('tr');

        // Create cells for store, model, and inventory
        const indexCell = document.createElement('td');
        indexCell.textContent = index++;

        const storeCell = document.createElement('td');
        storeCell.textContent = data.store;

        const modelCell = document.createElement('td');
        modelCell.textContent = data.model;

        const inventoryCell = document.createElement('td');
        inventoryCell.textContent = data.inventory;

        const updatedCell = document.createElement('td');
        updatedCell.textContent = data.updated;

        const statusCell = document.createElement('td');
        const low = data.inventory < 10;
        const high = data.inventory > 80;
        statusCell.textContent = low ? 'Low' : high ? 'High' : 'OK';
        statusCell.style.backgroundColor = low ? '#f53e31' : high ? 'orange' : 'transparent';

        // Append cells to the row
        newRow.appendChild(indexCell);
        newRow.appendChild(storeCell);
        newRow.appendChild(modelCell);
        newRow.appendChild(inventoryCell);
        newRow.appendChild(updatedCell);
        newRow.appendChild(statusCell);

        // Append the row to the table body
        tableBody.appendChild(newRow);
    });
}