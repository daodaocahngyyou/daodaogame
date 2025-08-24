const axios = require('axios');

async function testtaskTimeFunctions() {
  try {
    console.log('测试订单上钟下钟功能...');
    
    // 首先登录获取 token
    const adminjson = await axios.post('http://localhost:10000/handler/v1/auth/admin', {
      username: 'admin',
      password: '123456'
    });
    
    const token = adminjson.data.data.accessToken;
    console.log('登录成功，获取到 token');
    
    // 设置请求头
    const headers = {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    };
    
    // 1. 获取订单列表
    console.log('\n=== 1. 获取订单列表 ===');
    try {
      const tasksjson = await axios.get('http://localhost:10000/handler/v1/tasks?page=1&limit=5', { headers });
      console.log('订单列表响应:', tasksjson.data);
      
      if (tasksjson.data.data && tasksjson.data.data.list && tasksjson.data.data.list.length > 0) {
        const task = tasksjson.data.data.list[0];
        console.log('选择第一个订单进行测试:', task.id);
        
        // 2. 测试上钟功能
        console.log('\n=== 2. 测试上钟功能 ===');
        try {
          const startjson = await axios.post(`http://localhost:10000/handler/v1/tasks/${task.id}/start`, {}, { headers });
          console.log('上钟成功:', startjson.data);
        } catch (error) {
          console.error('上钟失败:', error.json?.data || error.message);
        }
        
        // 3. 再次获取订单详情，查看上钟时间
        console.log('\n=== 3. 查看上钟后的订单详情 ===');
        try {
          const taskDetailjson = await axios.get(`http://localhost:10000/handler/v1/tasks/${task.id}`, { headers });
          console.log('订单详情:', taskDetailjson.data);
        } catch (error) {
          console.error('获取订单详情失败:', error.json?.data || error.message);
        }
        
        // 4. 测试下钟功能
        console.log('\n=== 4. 测试下钟功能 ===');
        try {
          const endjson = await axios.post(`http://localhost:10000/handler/v1/tasks/${task.id}/end`, {}, { headers });
          console.log('下钟成功:', endjson.data);
        } catch (error) {
          console.error('下钟失败:', error.json?.data || error.message);
        }
        
        // 5. 再次获取订单详情，查看下钟时间
        console.log('\n=== 5. 查看下钟后的订单详情 ===');
        try {
          const taskDetailjson2 = await axios.get(`http://localhost:10000/handler/v1/tasks/${task.id}`, { headers });
          console.log('订单详情:', taskDetailjson2.data);
        } catch (error) {
          console.error('获取订单详情失败:', error.json?.data || error.message);
        }
        
      } else {
        console.log('没有找到订单，无法进行测试');
      }
      
    } catch (error) {
      console.error('获取订单列表失败:', error.json?.data || error.message);
    }
    
    // 6. 测试获取即将下钟的订单列表
    console.log('\n=== 6. 测试获取即将下钟的订单列表 ===');
    try {
      const endingSoonjson = await axios.get('http://localhost:10000/handler/v1/tasks/ending-soon?minutes=30', { headers });
      console.log('即将下钟订单列表:', endingSoonjson.data);
    } catch (error) {
      console.error('获取即将下钟订单失败:', error.json?.data || error.message);
    }
    
  } catch (error) {
    console.error('测试失败:', error.json?.data || error.message);
  }
}

testtaskTimeFunctions();
