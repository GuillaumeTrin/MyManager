import { Chart, registerables } from 'chart.js';

const initGlobalChart = () => {
    const ctx = document.getElementById('myGlobalChart');
    if (!ctx)
    return
    const data_element = JSON.parse(ctx.dataset.stats);
  

}