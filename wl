<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
<title>MOTOR LAB · 电动机智能仿真平台</title>
<style>
:root{
  --bg:#070b14;
  --panel:#0f1826cc;
  --panel2:#0b1220;
  --line:#1e2f45;
  --cyan:#00e5ff;
  --green:#00ffa3;
  --amber:#ffb300;
  --red:#ff3b5c;
  --purple:#b467ff;
  --blue:#3d7bff;
  --txt:#c8d8ec;
  --txt-dim:#5d7ba0;
}
*{box-sizing:border-box;margin:0;padding:0;-webkit-tap-highlight-color:transparent}
html,body{height:100%}
body{
  background:radial-gradient(ellipse at 20% 0%,#0d1a2e 0%,#05080f 55%,#02040a 100%);
  color:var(--txt);
  font-family:'SF Mono',Menlo,Consolas,monospace;
  min-height:100vh;
  padding:12px;
  display:flex;justify-content:center;align-items:flex-start;
  overflow-x:hidden;
}
body::before{
  content:'';position:fixed;inset:0;pointer-events:none;
  background:
    repeating-linear-gradient(0deg,rgba(0,229,255,.03) 0 1px,transparent 1px 3px),
    radial-gradient(circle at 80% 90%,rgba(180,103,255,.08),transparent 50%);
  z-index:0;
}
.app{
  position:relative;z-index:1;
  width:100%;max-width:1400px;
  background:linear-gradient(180deg,#0a1220ee,#070d18ee);
  border:1px solid #1c2f47;
  border-radius:18px;
  padding:16px;
  box-shadow:0 0 60px rgba(0,229,255,.06),0 30px 80px rgba(0,0,0,.8),inset 0 1px 0 rgba(255,255,255,.04);
  backdrop-filter:blur(12px);
}
/* 顶部栏 */
.topbar{
  display:flex;align-items:center;gap:12px;flex-wrap:wrap;
  padding-bottom:12px;border-bottom:1px solid #16283d;margin-bottom:14px;
}
.logo{
  display:flex;align-items:center;gap:10px;font-size:15px;font-weight:700;letter-spacing:2px;
  color:#e6f4ff;text-shadow:0 0 16px rgba(0,229,255,.5);
}
.logo-dot{
  width:10px;height:10px;border-radius:50%;background:var(--cyan);
  box-shadow:0 0 12px var(--cyan),0 0 24px var(--cyan);
  animation:pulse 1.8s infinite;
}
@keyframes pulse{0%,100%{opacity:1}50%{opacity:.35}}
.logo small{color:var(--txt-dim);font-weight:400;font-size:10px;letter-spacing:1px}
.top-status{
  margin-left:auto;display:flex;gap:8px;align-items:center;flex-wrap:wrap;
}
.chip{
  font-size:10px;letter-spacing:1px;padding:5px 12px;border-radius:20px;
  border:1px solid #24405d;background:#0a1422;color:#7fa9d0;
  text-transform:uppercase;
}
.chip.on{color:var(--green);border-color:#0d4a38;background:#071a16;box-shadow:0 0 14px rgba(0,255,163,.25)}
.chip.off{color:var(--red);border-color:#4a0d1c;background:#1a070c;box-shadow:0 0 14px rgba(255,59,92,.25)}
/* 布局 */
.grid{display:grid;grid-template-columns:1fr 1fr;gap:12px}
@media(max-width:880px){.grid{grid-template-columns:1fr}}
/* 面板 */
.panel{
  background:linear-gradient(180deg,#0c1624cc,#080f1acc);
  border:1px solid #1b2c42;
  border-radius:14px;
  padding:12px;
  position:relative;
  overflow:hidden;
}
.panel::before{
  content:'';position:absolute;top:0;left:0;right:0;height:1px;
  background:linear-gradient(90deg,transparent,#00e5ff55,transparent);
}
.panel-title{
  display:flex;justify-content:space-between;align-items:center;
  font-size:10px;letter-spacing:2px;text-transform:uppercase;
  color:#6d8fb4;margin-bottom:10px;
}
.panel-title .tag{
  font-size:9px;color:#3d5d80;letter-spacing:1px;
}
canvas{display:block;width:100%;height:auto;border-radius:10px;background:#04080e;cursor:pointer}
/* 数据网格 */
.metrics{display:grid;grid-template-columns:repeat(2,1fr);gap:8px;margin-bottom:10px}
.metric{
  background:linear-gradient(180deg,#0a1420,#060b14);
  border:1px solid #16283d;border-radius:10px;padding:9px 10px;
  position:relative;overflow:hidden;
}
.metric .k{font-size:9px;letter-spacing:1.5px;color:#58789e;text-transform:uppercase}
.metric .v{font-size:17px;font-weight:700;margin-top:3px;font-variant-numeric:tabular-nums}
.metric .u{font-size:9px;color:#4a6a8e;margin-left:2px}
.metric.a .v{color:var(--amber);text-shadow:0 0 14px rgba(255,179,0,.4)}
.metric.g .v{color:var(--green);text-shadow:0 0 14px rgba(0,255,163,.4)}
.metric.p .v{color:var(--purple);text-shadow:0 0 14px rgba(180,103,255,.4)}
.metric.c .v{color:var(--cyan);text-shadow:0 0 14px rgba(0,229,255,.4)}
.metric.r .v{color:var(--red);text-shadow:0 0 14px rgba(255,59,92,.4)}
/* 进度条 */
.bar{height:4px;background:#0d1a2b;border-radius:4px;margin-top:6px;overflow:hidden}
.bar i{display:block;height:100%;width:0;border-radius:4px;transition:width .12s}
.bar i.a{background:linear-gradient(90deg,#ffb300,#ffd966);box-shadow:0 0 8px #ffb300aa}
.bar i.g{background:linear-gradient(90deg,#00ffa3,#7dffce);box-shadow:0 0 8px #00ffa3aa}
.bar i.p{background:linear-gradient(90deg,#b467ff,#d9b3ff);box-shadow:0 0 8px #b467ffaa}
.bar i.c{background:linear-gradient(90deg,#00e5ff,#7df2ff);box-shadow:0 0 8px #00e5ffaa}
/* 滑块 */
.slider-wrap{margin:10px 0 6px}
.slider-head{display:flex;justify-content:space-between;font-size:10px;color:#6d8fb4;letter-spacing:1px;margin-bottom:6px}
.slider-head b{color:var(--purple);font-size:12px;text-shadow:0 0 12px rgba(180,103,255,.6)}
input[type=range]{
  -webkit-appearance:none;width:100%;height:5px;border-radius:4px;outline:none;
  background:linear-gradient(90deg,#1a2c42,#3d2a5e 45%,#b467ff);
}
input[type=range]::-webkit-slider-thumb{
  -webkit-appearance:none;width:20px;height:20px;border-radius:50%;
  background:radial-gradient(circle at 35% 35%,#fff,#b467ff 60%);
  border:2px solid #e0c4ff;cursor:pointer;
  box-shadow:0 0 14px #b467ff,0 0 28px #b467ff88;
}
input[type=range]::-moz-range-thumb{
  width:20px;height:20px;border-radius:50%;border:2px solid #e0c4ff;
  background:#b467ff;cursor:pointer;box-shadow:0 0 14px #b467ff;
}
/* 按钮 */
.btn-row{display:flex;gap:8px;margin-top:10px}
.btn{
  flex:1;padding:11px;border-radius:10px;border:1px solid;
  font-family:inherit;font-size:11px;font-weight:700;letter-spacing:1.5px;
  cursor:pointer;transition:.15s;text-transform:uppercase;
  position:relative;overflow:hidden;
}
.btn:active{transform:scale(.97)}
.btn.lock{
  background:linear-gradient(180deg,#2a0a12,#1a050a);color:var(--red);
  border-color:#5a1224;box-shadow:0 0 16px rgba(255,59,92,.15);
}
.btn.lock:hover{box-shadow:0 0 24px rgba(255,59,92,.4);border-color:var(--red)}
.btn.reset{
  background:linear-gradient(180deg,#0a1a2e,#050e1a);color:var(--cyan);
  border-color:#12505a;box-shadow:0 0 16px rgba(0,229,255,.15);
}
.btn.reset:hover{box-shadow:0 0 24px rgba(0,229,255,.4);border-color:var(--cyan)}
/* 状态灯 */
.statusbar{
  display:flex;justify-content:space-between;align-items:center;
  margin-top:10px;padding:8px 12px;border-radius:10px;
  background:#060c14;border:1px solid #16283d;font-size:10px;letter-spacing:1px;
}
.led{
  width:9px;height:9px;border-radius:50%;display:inline-block;margin-left:6px;
  background:var(--green);box-shadow:0 0 10px var(--green);animation:pulse 1.5s infinite;
}
.led.s{background:var(--red);box-shadow:0 0 10px var(--red)}
/* 图例 */
.legend{
  display:flex;flex-wrap:wrap;gap:10px;font-size:9px;
  color:#58789e;margin-top:8px;letter-spacing:.5px;
}
.legend span{display:flex;align-items:center;gap:4px}
.legend .dot{width:7px;height:7px;border-radius:50%}
/* 底部 */
.foot{
  text-align:center;font-size:9px;color:#2f4a68;letter-spacing:1px;
  margin-top:12px;padding-top:10px;border-top:1px solid #10203a;
}
</style>
</head>
<body>
<div class="app">
  <!-- 顶部状态栏 -->
  <div class="topbar">
    <div class="logo">
      <div class="logo-dot"></div>
      MOTOR LAB
      <small>智能电动机仿真平台 v2.0</small>
    </div>
    <div class="top-status">
      <div class="chip" id="chipStall">● 转子状态</div>
      <div class="chip on" id="chipSys">● 系统在线</div>
    </div>
  </div>

  <div class="grid">
    <!-- 左列 -->
    <div>
      <!-- 电路 -->
      <div class="panel" style="margin-bottom:12px">
        <div class="panel-title">
          <span>◈ 电路拓扑</span>
          <span class="tag">点击画布切换 · CLICK TO TOGGLE</span>
        </div>
        <canvas id="cvs" width="520" height="320"></canvas>
      </div>
      <!-- U-I -->
      <div class="panel">
        <div class="panel-title">
          <span>◈ U-I 特性曲线</span>
          <span class="tag">五次实验描点</span>
        </div>
        <canvas id="uic" width="520" height="230"></canvas>
        <div class="legend">
          <span><i class="dot" style="background:#ffb300"></i>U=12V</span>
          <span><i class="dot" style="background:#00ffa3"></i>实验点</span>
          <span><i class="dot" style="background:#b467ff"></i>当前点</span>
          <span><i class="dot" style="background:#ff3b5c"></i>堵转点</span>
        </div>
      </div>
    </div>

    <!-- 右列 -->
    <div>
      <!-- 曲线 -->
      <div class="panel" style="margin-bottom:12px">
        <div class="panel-title">
          <span>◈ 多参数响应曲线</span>
          <span class="tag">Rp 扫描 2Ω → 50Ω</span>
        </div>
        <canvas id="curveCvs" width="520" height="250"></canvas>
        <div class="legend">
          <span><i class="dot" style="background:#ffb300"></i>I总</span>
          <span><i class="dot" style="background:#00ffa3"></i>IM</span>
          <span><i class="dot" style="background:#b467ff"></i>IR</span>
          <span><i class="dot" style="background:#00e5ff"></i>V端</span>
          <span><i class="dot" style="background:#3d7bff"></i>转速</span>
        </div>
      </div>

      <!-- 数据 -->
      <div class="panel" style="margin-bottom:12px">
        <div class="panel-title">
          <span>◈ 实时遥测</span>
          <span class="tag" id="stLbl">NORMAL</span>
        </div>
        <div class="metrics">
          <div class="metric a">
            <div class="k">总电流 I总</div>
            <div class="v" id="v1">0.00<span class="u">A</span></div>
            <div class="bar"><i class="a" id="b1"></i></div>
          </div>
          <div class="metric g">
            <div class="k">电机电流 IM</div>
            <div class="v" id="v2">0.00<span class="u">A</span></div>
            <div class="bar"><i class="g" id="b2"></i></div>
          </div>
          <div class="metric p">
            <div class="k">电阻电流 IR</div>
            <div class="v" id="v3">0.00<span class="u">A</span></div>
            <div class="bar"><i class="p" id="b3"></i></div>
          </div>
          <div class="metric c">
            <div class="k">反电动势 E</div>
            <div class="v" id="v4">0.00<span class="u">V</span></div>
            <div class="bar"><i class="c" id="b4"></i></div>
          </div>
          <div class="metric c">
            <div class="k">端电压 V端</div>
            <div class="v" id="v6">0.00<span class="u">V</span></div>
            <div class="bar"><i class="c" id="b6"></i></div>
          </div>
          <div class="metric r">
            <div class="k">转速</div>
            <div class="v" id="v5">0<span class="u">%</span></div>
            <div class="bar"><i class="a" id="b5"></i></div>
          </div>
        </div>
        <div class="statusbar">
          <span>MOTOR STATUS</span>
          <span><span id="stTxt">FREE SPIN</span><span class="led" id="led"></span></span>
        </div>
      </div>

      <!-- 控制 -->
      <div class="panel">
        <div class="panel-title">
          <span>◈ 控制台</span>
          <span class="tag">CONTROL UNIT</span>
        </div>
        <div class="slider-wrap">
          <div class="slider-head">
            <span>并联电阻 Rp</span>
            <b id="rLbl">10.0 Ω</b>
          </div>
          <input type="range" id="rSlider" min="2" max="50" value="10" step="0.5">
        </div>
        <div class="btn-row">
          <button class="btn lock" id="bLock">◉ 卡住转子</button>
          <button class="btn reset" id="bReset">↺ 复位系统</button>
        </div>
      </div>
    </div>
  </div>

  <div class="foot">MOTOR LAB · I总 = IM + IR · 堵转时反电动势为 0 · 拖动滑块实时扫描</div>
</div>

<script>
(function(){
  const V=12, Ri=0.5, Ra=1.2, E_N=7.24, E_S=0;
  let stalled=false, emf=E_N, speed=1, Rp=10;

  const experiments=[], MAX_EXP=5;

  const cvs=document.getElementById('cvs'), ctx=cvs.getContext('2d');
  const uic=document.getElementById('uic'), uctx=uic.getContext('2d');
  const curveCvs=document.getElementById('curveCvs'), cctx=curveCvs.getContext('2d');
  const W=cvs.width,H=cvs.height,UW=uic.width,UH=uic.height,CW=curveCvs.width,CH=curveCvs.height;
  const $=id=>document.getElementById(id);

  function calc(e,rp){
    const Vn=(V/Ri+e/Ra)/(1/Ri+1/Ra+1/rp);
    const It=(V-Vn)/Ri;
    const Im=Math.max(0,(Vn-e)/Ra);
    const Ir=Vn/rp;
    return {Vn,It,Im,Ir};
  }

  function recordExperiment(){
    const d=calc(emf,Rp);
    experiments.push({Rp,Im:d.Im,Vn:d.Vn,It:d.It,stalled});
    if(experiments.length>MAX_EXP)experiments.shift();
  }

  /* ===== 电路绘制 (科技风) ===== */
  function drawCircuit(d){
    const {It,Im,Ir,Vn}=d;
    ctx.fillStyle='#04080e';ctx.fillRect(0,0,W,H);
    // 网格
    ctx.strokeStyle='#0d1a2b';ctx.lineWidth=1;
    for(let i=0;i<W;i+=26){ctx.beginPath();ctx.moveTo(i,0);ctx.lineTo(i,H);ctx.stroke()}
    for(let i=0;i<H;i+=26){ctx.beginPath();ctx.moveTo(0,i);ctx.lineTo(W,i);ctx.stroke()}

    const L=62,R=W-62,T=48,B=H-58,by=(T+B)/2,mx=(L+R)/2-40;

    // 发光导线 (两层)
    function wire(x1,y1,x2,y2,color){
      ctx.strokeStyle=color+'33';ctx.lineWidth=9;
      ctx.beginPath();ctx.moveTo(x1,y1);ctx.lineTo(x2,y2);ctx.stroke();
      ctx.strokeStyle=color;ctx.lineWidth=2.5;
      ctx.beginPath();ctx.moveTo(x1,y1);ctx.lineTo(x2,y2);ctx.stroke();
    }
    const wireColor='#2e7fb8';
    wire(L,T,R,T,wireColor);
    wire(R,T,R,B,wireColor);
    wire(R,B,mx+32,B,wireColor);
    wire(mx-32,B,L,B,wireColor);
    wire(L,T,L,by-16,wireColor);
    wire(L,by+8,L,B,wireColor);

    // 并联电阻支路
    const rx=mx+95,ry=B-70;
    wire(mx+32,B,mx+32,ry,wireColor);
    wire(mx+32,ry,rx-22,ry,wireColor);
    wire(rx+22,ry,rx+22,B,wireColor);
    wire(rx+22,B,mx+32,B,wireColor);

    // 电阻方块 (发光)
    ctx.shadowColor='#b467ff';ctx.shadowBlur=18;
    ctx.fillStyle='#1a0a2e';ctx.fillRect(rx-22,ry-11,44,22);
    ctx.strokeStyle='#b467ff';ctx.lineWidth=2;ctx.strokeRect(rx-22,ry-11,44,22);
    ctx.shadowBlur=0;
    ctx.fillStyle='#d9b3ff';ctx.font='bold 12px monospace';
    ctx.textAlign='center';ctx.textBaseline='middle';ctx.fillText('Rp',rx,ry);

    // 电源 (发光)
    ctx.shadowColor='#ffb300';ctx.shadowBlur=14;
    ctx.strokeStyle='#ffb300';ctx.lineWidth=4;
    ctx.beginPath();ctx.moveTo(L-14,by-16);ctx.lineTo(L+14,by-16);ctx.stroke();
    ctx.shadowBlur=0;
    ctx.strokeStyle='#2e7fb8';ctx.lineWidth=4;
    ctx.beginPath();ctx.moveTo(L-9,by+8);ctx.lineTo(L+9,by+8);ctx.stroke();
    // 内阻
    ctx.beginPath();ctx.moveTo(L,by+8);ctx.lineTo(L,by+24);
    ctx.lineWidth=2.5;ctx.strokeStyle='#4a7aa8';ctx.stroke();

    ctx.font='bold 11px monospace';ctx.fillStyle='#5d7ba0';ctx.textAlign='left';
    ctx.fillText('R_int',L-60,by+30);
    ctx.font='bold 15px monospace';ctx.fillStyle='#ffb300';
    ctx.shadowColor='#ffb300';ctx.shadowBlur=12;
    ctx.fillText('12V',L-78,by-28);ctx.shadowBlur=0;
    ctx.fillStyle='#ffb300';ctx.fillText('+',L+22,by-22);
    ctx.fillStyle='#2e7fb8';ctx.fillText('−',L+22,by+20);

    // 电动机
    const motorColor=stalled?'#ff3b5c':'#00e5ff';
    ctx.shadowColor=motorColor;ctx.shadowBlur=22;
    ctx.beginPath();ctx.arc(mx,B,28,0,7);
    ctx.fillStyle='#060d16';ctx.fill();
    ctx.strokeStyle=motorColor;ctx.lineWidth=3;ctx.stroke();
    ctx.shadowBlur=0;
    ctx.fillStyle=motorColor;ctx.font='bold 20px monospace';
    ctx.textAlign='center';ctx.textBaseline='middle';ctx.fillText('M',mx,B-2);

    // 转子标记
    ctx.save();ctx.translate(mx,B);
    if(stalled){
      ctx.shadowColor='#ff3b5c';ctx.shadowBlur=14;
      ctx.strokeStyle='#ff3b5c';ctx.lineWidth=3.5;
      ctx.beginPath();ctx.moveTo(-11,-11);ctx.lineTo(11,11);ctx.moveTo(11,-11);ctx.lineTo(-11,11);ctx.stroke();
    }else{
      ctx.shadowColor='#00e5ff';ctx.shadowBlur=14;
      ctx.strokeStyle='#00e5ff';ctx.lineWidth=2.5;
      ctx.beginPath();ctx.arc(0,0,16,0.3,5.5);ctx.stroke();
      ctx.beginPath();ctx.fillStyle='#00e5ff';
      ctx.moveTo(10,-14);ctx.lineTo(20,-8);ctx.lineTo(13,-1);ctx.fill();
    }
    ctx.shadowBlur=0;ctx.restore();

    // 电流流动粒子
    const n=Math.min(14,Math.floor(It*2)+2),sp=(R-L)/(n+1);
    for(let i=0;i<n;i++){
      const off=(Date.now()/120)%sp;
      const x=L+((i*sp+off)%(R-L));
      if(x<R-8){
        ctx.beginPath();ctx.arc(x,T,3.5,0,7);
        ctx.fillStyle=stalled?'#ffb300':'#00e5ff';
        ctx.shadowColor=ctx.fillStyle;ctx.shadowBlur=14;ctx.fill();
      }
    }
    ctx.shadowBlur=0;

    // 数据文字
    ctx.textAlign='left';ctx.font='bold 12px monospace';
    ctx.fillStyle='#ffb300';ctx.fillText('I总 '+It.toFixed(2)+' A',14,24);
    ctx.fillStyle='#00ffa3';ctx.fillText('IM  '+Im.toFixed(2)+' A',14,44);
    ctx.fillStyle='#b467ff';ctx.fillText('IR  '+Ir.toFixed(2)+' A',14,64);
    ctx.fillStyle='#00e5ff';ctx.fillText('V端 '+Vn.toFixed(2)+' V',14,84);

    // 状态标签
    ctx.font='bold 12px monospace';
    ctx.fillStyle=motorColor;
    ctx.shadowColor=motorColor;ctx.shadowBlur=12;
    ctx.fillText(stalled?'⚠ STALL':'● RUNNING',mx+38,B-36);
    ctx.shadowBlur=0;
  }

  /* ===== U-I 图 ===== */
  function drawUI(d){
    const {Im,Vn}=d;
    uctx.fillStyle='#04080e';uctx.fillRect(0,0,UW,UH);
    const m={l:46,r:20,t:18,b:34},pw=UW-m.l-m.r,ph=UH-m.t-m.b;
    const Imax=9,Umax=14;
    const X=i=>m.l+(i/Imax)*pw,Y=u=>m.t+ph-(u/Umax)*ph;

    // 网格
    uctx.strokeStyle='#0d1a2b';uctx.lineWidth=.8;
    for(let i=0;i<=9;i+=2){uctx.beginPath();uctx.moveTo(X(i),m.t);uctx.lineTo(X(i),m.t+ph);uctx.stroke()}
    for(let u=0;u<=14;u+=2){uctx.beginPath();uctx.moveTo(m.l,Y(u));uctx.lineTo(m.l+pw,Y(u));uctx.stroke()}
    // 轴
    uctx.strokeStyle='#1e3a56';uctx.lineWidth=1.5;
    uctx.beginPath();uctx.moveTo(m.l,m.t);uctx.lineTo(m.l,m.t+ph);uctx.stroke();
    uctx.beginPath();uctx.moveTo(m.l,m.t+ph);uctx.lineTo(m.l+pw,m.t+ph);uctx.stroke();
    // 刻度
    uctx.font='9px monospace';uctx.fillStyle='#3d5d80';uctx.textAlign='center';
    for(let i=0;i<=8;i+=2)uctx.fillText(i,X(i),m.t+ph+13);
    uctx.textAlign='right';
    for(let u=0;u<=14;u+=2)uctx.fillText(u,m.l-5,Y(u)+3);
    uctx.font='bold 10px monospace';uctx.fillStyle='#5d7ba0';
    uctx.textAlign='center';uctx.fillText('I (A)',m.l+pw/2,UH-5);
    uctx.save();uctx.translate(11,m.t+ph/2);uctx.rotate(-Math.PI/2);
    uctx.fillText('U (V)',0,0);uctx.restore();

    // 电源线
    uctx.strokeStyle='#ffb300';uctx.lineWidth=1.8;uctx.setLineDash([7,5]);
    uctx.shadowColor='#ffb300';uctx.shadowBlur=8;
    uctx.beginPath();uctx.moveTo(m.l,Y(12));uctx.lineTo(m.l+pw,Y(12));uctx.stroke();
    uctx.setLineDash([]);uctx.shadowBlur=0;
    uctx.font='bold 9px monospace';uctx.fillStyle='#ffb300';uctx.textAlign='right';
    uctx.fillText('U=12V',m.l+pw-4,Y(12)-5);

    // 反电动势线
    uctx.strokeStyle='#00e5ff';uctx.setLineDash([4,4]);
    uctx.shadowColor='#00e5ff';uctx.shadowBlur=8;
    uctx.beginPath();uctx.moveTo(m.l,Y(emf));uctx.lineTo(m.l+pw,Y(emf));uctx.stroke();
    uctx.setLineDash([]);uctx.shadowBlur=0;
    uctx.fillStyle='#00e5ff';uctx.textAlign='left';
    uctx.fillText('E='+emf.toFixed(2)+'V',m.l+4,Y(emf)-5);

    // 实验点连线
    if(experiments.length>=2){
      const sorted=[...experiments].sort((a,b)=>a.Im-b.Im);
      uctx.beginPath();uctx.strokeStyle='#00ffa3';uctx.lineWidth=1.8;uctx.setLineDash([6,4]);
      sorted.forEach((p,i)=>{
        const px=X(p.Im),py=Y(p.Vn);
        i===0?uctx.moveTo(px,py):uctx.lineTo(px,py);
      });
      uctx.stroke();uctx.setLineDash([]);
    }

    // 实验点
    experiments.forEach((exp,idx)=>{
      const px=X(exp.Im),py=Y(exp.Vn);
      const color=exp.stalled?'#ff3b5c':'#00ffa3';
      uctx.beginPath();uctx.arc(px,py,8,0,7);
      uctx.fillStyle=color+'22';uctx.fill();
      uctx.beginPath();uctx.arc(px,py,4.5,0,7);
      uctx.fillStyle=color;uctx.shadowColor=color;uctx.shadowBlur=14;uctx.fill();
      uctx.shadowBlur=0;
      uctx.fillStyle='#04080e';uctx.font='bold 8px monospace';
      uctx.textAlign='center';uctx.textBaseline='middle';
      uctx.fillText((idx+1).toString(),px,py);
    });
    uctx.textBaseline='alphabetic';

    // 当前点
    const cx=X(Im),cy=Y(Vn);
    uctx.beginPath();uctx.arc(cx,cy,12,0,7);
    uctx.strokeStyle='#b467ff';uctx.lineWidth=2;uctx.setLineDash([3,3]);
    uctx.shadowColor='#b467ff';uctx.shadowBlur=12;
    uctx.stroke();uctx.setLineDash([]);uctx.shadowBlur=0;

    // 堵转点
    const sd=calc(0,Rp),sx=X(sd.Im),sy=Y(sd.Vn);
    uctx.beginPath();uctx.arc(sx,sy,5,0,7);
    uctx.strokeStyle='#ff3b5c';uctx.lineWidth=1.5;uctx.setLineDash([3,3]);uctx.stroke();uctx.setLineDash([]);
    uctx.fillStyle='#ff3b5c88';uctx.font='8px monospace';uctx.textAlign='center';
    uctx.fillText('STALL',sx,sy+14);
  }

  /* ===== 多曲线 ===== */
  function drawCurves(){
    cctx.fillStyle='#04080e';cctx.fillRect(0,0,CW,CH);
    const m={l:48,r:36,t:22,b:32},pw=CW-m.l-m.r,ph=CH-m.t-m.b;
    const rpMin=2,rpMax=50,N=80;
    const pts=[];
    for(let i=0;i<=N;i++){
      const rp=rpMin+(rpMax-rpMin)*i/N;
      pts.push({rp,...calc(emf,rp)});
    }
    const YmaxI=9,YmaxV=14;
    const X=rp=>m.l+(rp-rpMin)/(rpMax-rpMin)*pw;
    const YI=i=>m.t+ph-(i/YmaxI)*ph;
    const YV=v=>m.t+ph-(v/YmaxV)*ph;

    // 网格
    cctx.strokeStyle='#0d1a2b';cctx.lineWidth=.8;
    for(let rp=5;rp<=50;rp+=5){
      const x=X(rp);
      cctx.beginPath();cctx.moveTo(x,m.t);cctx.lineTo(x,m.t+ph);cctx.stroke();
    }
    for(let i=0;i<=9;i+=2){
      const y=YI(i);
      cctx.beginPath();cctx.moveTo(m.l,y);cctx.lineTo(m.l+pw,y);cctx.stroke();
    }
    // 轴
    cctx.strokeStyle='#1e3a56';cctx.lineWidth=1.5;
    cctx.beginPath();cctx.moveTo(m.l,m.t);cctx.lineTo(m.l,m.t+ph);cctx.stroke();
    cctx.beginPath();cctx.moveTo(m.l+pw,m.t);cctx.lineTo(m.l+pw,m.t+ph);cctx.stroke();
    cctx.beginPath();cctx.moveTo(m.l,m.t+ph);cctx.lineTo(m.l+pw,m.t+ph);cctx.stroke();

    // 刻度
    cctx.font='9px monospace';cctx.fillStyle='#3d5d80';cctx.textAlign='center';
    for(let rp=5;rp<=50;rp+=5)cctx.fillText(rp,X(rp),m.t+ph+13);
    cctx.textAlign='right';
    cctx.fillStyle='#ffb300';
    for(let i=0;i<=8;i+=2)cctx.fillText(i,m.l-5,YI(i)+3);
    cctx.textAlign='left';
    cctx.fillStyle='#00e5ff';
    for(let v=0;v<=14;v+=2)cctx.fillText(v,m.l+pw+5,YV(v)+3);

    // 轴标题
    cctx.font='bold 9px monospace';
    cctx.fillStyle='#ffb300';cctx.textAlign='center';
    cctx.save();cctx.translate(11,m.t+ph/2);cctx.rotate(-Math.PI/2);
    cctx.fillText('I (A)',0,0);cctx.restore();
    cctx.fillStyle='#00e5ff';
    cctx.save();cctx.translate(CW-9,m.t+ph/2);cctx.rotate(Math.PI/2);
    cctx.fillText('V (V)',0,0);cctx.restore();
    cctx.fillStyle='#5d7ba0';cctx.textAlign='center';
    cctx.fillText('Rp (Ω)',m.l+pw/2,CH-6);

    // 曲线绘制函数
    function curve(key,color,useV,width,dash){
      cctx.beginPath();cctx.strokeStyle=color;cctx.lineWidth=width;
      if(dash)cctx.setLineDash(dash);
      cctx.shadowColor=color;cctx.shadowBlur=10;
      pts.forEach((p,i)=>{
        const y=useV?YV(p[key]):YI(key==='speed'?p[key]*8:p[key]);
        i===0?cctx.moveTo(X(p.rp),y):cctx.lineTo(X(p.rp),y);
      });
      cctx.stroke();cctx.setLineDash([]);cctx.shadowBlur=0;
    }

    curve('It','#ffb300',false,2.2);
    curve('Im','#00ffa3',false,2.2);
    curve('Ir','#b467ff',false,2.2);
    curve('Vn','#00e5ff',true,2,[5,3]);
    // 转速单独处理
    cctx.beginPath();cctx.strokeStyle='#3d7bff';cctx.lineWidth=1.8;cctx.setLineDash([2,3]);
    cctx.shadowColor='#3d7bff';cctx.shadowBlur=8;
    pts.forEach((p,i)=>{
      const y=YI(speed*8);
      i===0?cctx.moveTo(X(p.rp),y):cctx.lineTo(X(p.rp),y);
    });
    cctx.stroke();cctx.setLineDash([]);cctx.shadowBlur=0;

    // 当前 Rp 参考线
    const curX=X(Rp),cd=calc(emf,Rp);
    cctx.beginPath();cctx.strokeStyle='#ffffff22';cctx.lineWidth=1.2;cctx.setLineDash([4,4]);
    cctx.moveTo(curX,m.t);cctx.lineTo(curX,m.t+ph);cctx.stroke();cctx.setLineDash([]);

    // 当前各点
    const marks=[
      {y:YI(cd.It),c:'#ffb300'},
      {y:YI(cd.Im),c:'#00ffa3'},
      {y:YI(cd.Ir),c:'#b467ff'},
      {y:YV(cd.Vn),c:'#00e5ff'},
      {y:YI(speed*8),c:'#3d7bff'}
    ];
    marks.forEach(mk=>{
      cctx.beginPath();cctx.arc(curX,mk.y,4.5,0,7);
      cctx.fillStyle=mk.c;cctx.shadowColor=mk.c;cctx.shadowBlur=14;
      cctx.fill();cctx.shadowBlur=0;
    });
  }

  /* ===== 更新 ===== */
  function update(){
    emf=stalled?E_S:E_N;
    speed=stalled?0:1;
    const d=calc(emf,Rp);
    const M=9;
    $('v1').innerHTML=d.It.toFixed(2)+'<span class="u">A</span>';$('b1').style.width=Math.min(100,d.It/M*100)+'%';
    $('v2').innerHTML=d.Im.toFixed(2)+'<span class="u">A</span>';$('b2').style.width=Math.min(100,d.Im/M*100)+'%';
    $('v3').innerHTML=d.Ir.toFixed(2)+'<span class="u">A</span>';$('b3').style.width=Math.min(100,d.Ir/M*100)+'%';
    $('v4').innerHTML=emf.toFixed(2)+'<span class="u">V</span>';$('b4').style.width=(emf/12*100)+'%';
    $('v6').innerHTML=d.Vn.toFixed(2)+'<span class="u">V</span>';$('b6').style.width=(d.Vn/12*100)+'%';
    $('v5').innerHTML=(speed*100)+'<span class="u">%</span>';$('b5').style.width=(speed*100)+'%';
    $('stTxt').textContent=stalled?'STALLED':'FREE SPIN';
    $('led').className='led'+(stalled?' s':'');
    $('stLbl').textContent=stalled?'⚠ STALL':'● NORMAL';
    $('chipStall').className='chip '+(stalled?'off':'on');
    $('chipStall').textContent=stalled?'● 堵转中':'● 转子正常';
    drawCircuit(d);drawUI(d);drawCurves();
  }

  /* ===== 事件 ===== */
  $('bLock').onclick=()=>{if(!stalled){stalled=true;recordExperiment();update();}};
  $('bReset').onclick=()=>{if(stalled){stalled=false;recordExperiment();update();}};
  cvs.onclick=()=>{stalled=!stalled;recordExperiment();update();};
  $('rSlider').oninput=e=>{
    Rp=parseFloat(e.target.value);
    $('rLbl').textContent=Rp.toFixed(1)+' Ω';
    update();
  };

  (function initExperiments(){
    const d1=calc(E_N,10);
    experiments.push({Rp:10,Im:d1.Im,Vn:d1.Vn,It:d1.It,stalled:false});
    const d2=calc(E_S,10);
    experiments.push({Rp:10,Im:d2.Im,Vn:d2.Vn,It:d2.It,stalled:true});
  })();

  $('rLbl').textContent=Rp.toFixed(1)+' Ω';
  (function loop(){update();requestAnimationFrame(loop)})();
})();
</script>
</body>
</html>
