import { Chart, registerables } from 'chart.js';

const initChart = () => {
    const ctx = document.getElementById('myChart');
    if (!ctx)
    return
    const data_element = JSON.parse(ctx.dataset.stats);
   
    if (!ctx)
      return

    const data = {
      
        datasets: [{
          label: 'My Artist Interactions  This Week',
          backgroundColor: 'rgb(255, 99, 132)',
          borderColor: 'rgb(255, 99, 132)',
          data: data_element,
        //   data: [{x:'2016-12-25', y:20}, {x:'2016-12-26', y:10}],
        }]
      };
    const config = {
        type: 'line',
        data,
        options: {}
      };
    
      Chart.register(...registerables);
      const myChart = new Chart(
        ctx,
        config
      );
   
}


export { initChart }