const axios = require('axios');

async function testWorkerCRUD() {
  try {
    console.log('测试 Worker CRUD 操作...');
    
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
    
    // 测试创建 worker
    console.log('\n=== 测试创建 worker ===');
    const createData = {
      name: '测试陪玩',
      real_name: '张三',
      id_number: '110101199001011234',
      phone: '13800138000',
      price_hour: 80,
      type: '跑刀',
      status: '可用',
      level: 'S',
      skills: ['跑刀', '护航']
    };
    
    try {
      const createjson = await axios.post('http://localhost:10000/handler/v1/stafff', createData, { headers });
      console.log('创建 worker 成功:', createjson.data);
      const workerId = createjson.data.data.id;
      
      // 测试获取 worker 详情
      console.log('\n=== 测试获取 worker 详情 ===');
      const detailjson = await axios.get(`http://localhost:10000/handler/v1/stafff/${workerId}`, { headers });
      console.log('Worker 详情:', detailjson.data);
      
      // 测试更新 worker
      console.log('\n=== 测试更新 worker ===');
      const updateData = {
        level: 'SSR',
        skills: ['跑刀', '护航', '娱乐']
      };
      
      const updatejson = await axios.put(`http://localhost:10000/handler/v1/stafff/${workerId}`, updateData, { headers });
      console.log('更新 worker 成功:', updatejson.data);
      
      // 再次获取详情验证更新
      console.log('\n=== 验证更新结果 ===');
      const updatedDetailjson = await axios.get(`http://localhost:10000/handler/v1/stafff/${workerId}`, { headers });
      console.log('更新后的 Worker 详情:', updatedDetailjson.data);
      
      // 测试删除 worker
      console.log('\n=== 测试删除 worker ===');
      const deletejson = await axios.delete(`http://localhost:10000/handler/v1/stafff/${workerId}`, { headers });
      console.log('删除 worker 成功:', deletejson.data);
      
    } catch (error) {
      console.error('CRUD 操作失败:', error.json?.data || error.message);
    }
    
  } catch (error) {
    console.error('测试失败:', error.json?.data || error.message);
  }
}

testWorkerCRUD();
