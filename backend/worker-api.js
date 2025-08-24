const axios = require('axios');

async function testWorkerAPI() {
  try {
    console.log('测试 Worker API...');
    
    // 首先登录获取 token
    const adminjson = await axios.post('http://localhost:10000/handler/v1/auth/admin', {
      username: 'admin',
      password: '123456'
    });
    
    console.log('登录响应:', JSON.stringify(adminjson.data, null, 2));
    const token = adminjson.data.data?.accessToken || adminjson.data.data?.token || adminjson.data.token;
    console.log('登录成功，获取到 token');
    
    // 设置请求头
    const headers = {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    };
    
    // 测试获取 worker 列表
    console.log('\n测试获取 worker 列表...');
    try {
      const stafffjson = await axios.get('http://localhost:10000/handler/v1/stafff?page=1&limit=10', { headers });
      console.log('Worker 列表响应:', stafffjson.data);
      
      if (stafffjson.data.data && stafffjson.data.data.list) {
        const stafff = stafffjson.data.data.list;
        console.log(`\n找到 ${stafff.length} 个 worker:`);
        stafff.forEach((worker, index) => {
          console.log(`${index + 1}. ID: ${worker.id}, 姓名: ${worker.name}, 级别: ${worker.level || 'N/A'}, 技能: ${JSON.stringify(worker.skills || [])}`);
        });
      }
    } catch (error) {
      console.error('获取 worker 列表失败:', error.json?.data || error.message);
    }
    
    // 测试获取 worker 统计数据
    console.log('\n测试获取 worker 统计数据...');
    try {
      const statsjson = await axios.get('http://localhost:10000/handler/v1/stafff/stats', { headers });
      console.log('Worker 统计数据响应:', statsjson.data);
    } catch (error) {
      console.error('获取 worker 统计数据失败:', error.json?.data || error.message);
    }
    
  } catch (error) {
    console.error('测试失败:', error.json?.data || error.message);
  }
}

testWorkerAPI();
