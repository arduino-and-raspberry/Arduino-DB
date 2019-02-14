--��� ������ �� ������� �� ������
select cl.admdate, cl.client_ip, convert((cl.requestmessage),'CL8MSWIN1251','UTF8'), drec.deccription, cln.targetcompany, cl.*, cln.* 
from webauto.ws_common_logs cl, webauto.ws_calc_logs_new cln, webauto.ws_dct_reqsourcetype drec
where 1 = 1
and cl.calcid in (175130681) 
and cl.calcid = cln.calcid
and drec.id = cl.calcreqsourcetypeid
order by cl.admdate desc;

select * from ws_common_logs 
where calcid = 168813697;
select * from ws_calc_logs_new
where calcid = 169187175;

--��� ��������� ������������
select t.calcid, dc.name,dc.deccription,t.value
from WS_COEFF_CALC t, WS_DCT_COEFFICIENTS dc
where 1 = 1
and t.calcid =  175130681  
and t.coefid = dc.id;

--��� ������ �� ������� �������
select t.calcid, dp.name, dp.description, t.deductible_sum,t.premium_sum from WS_PREMIUM t, WS_DCT_PREMIUM dp
where 1 = 1
and t.calcid = 171444318 
and t.premiumtype = dp.id;

--������ �����������/������������� � �������
select p.*, dct.description from webauto.ws_partner p, webauto.ws_dct_parthner_type dct
where 1 = 1
and p.calcid in (173767854)   
and p.parthner_type = dct.id;

-- ������ ��������� � �������� 
select * from ws_drivers dr
where dr.calcid = 173767854 ;

--��������� �������
select cl.admdate, cl.calcid, cl.client_ip, convert((cl.requestmessage),'CL8MSWIN1251','UTF8'),
       drec.deccription,cl.server, cln.targetcompany, cl.agentid, cl.error,
       cln.osago, cln.casco, cln.damage,
       cln.theft, cln.dgo,cln.accident, cln.gap , cln.crash, cl.main_pnumber
from webauto.ws_common_logs cl, webauto.ws_calc_logs_new cln, webauto.ws_dct_reqsourcetype drec
where 1 = 1
and cl.calcid = cln.calcid
and drec.id = cl.calcreqsourcetypeid
and cl.calcreqsourcetypeid = 3
--and cl.agentid =5698159
--and cl.server = 'TEST'
and cln.casco = '�'
and cl.admdate >= trunc(sysdate) - 0.3
order by cl.admdate desc;
---------------------------------------------------------------------------------------------
---------------------------------------------�����-------------------------------------------
-- 239347 Dam �����
-- 239348 Thf �������
-- 11958115 Gap
-- 18715051 ������������
-- 68331 - ��� ������������ AT02_COM
-- 254301 - ������ �� ��
-- 401104 - �����

--��� ��������� ������������ �� ���������� �����
select t.calcid, dc.name,dc.deccription,t.value
from WS_COEFF_CALC t, WS_DCT_COEFFICIENTS dc, WS_DCT_COEFF_TO_RISK ctr
where 1 = 1
and t.calcid = 148114680
and t.coefid = dc.id
and ctr.coef = t.coefid
and ctr.risk = 18715051;

--����� ����������
select calcid from (
select cln.calcid, count (cl.id)
from  webauto.ws_common_logs cl, webauto.ws_calc_logs_new cln
where cln.calcid = cl.calcid
group by cln.calcid
having count (cl.id) > 1 
order by cln.calcid);

--�������� ����������
delete webauto.ws_common_logs cl
WHERE cl.calcid in (select calcid from (
                       select cln.calcid, count (cl.id)
                        from  webauto.ws_common_logs cl, webauto.ws_calc_logs_new cln
                        where cln.calcid = cl.calcid
                        group by cln.calcid
                        having count (cl.id) > 1))
and cl.client_ip = '192.168.200.17';                       
--and cl.admdate >= to_date('26.10.2017','dd.mm.yyyy');                       
--and cl.requestmessage is null;

--���-�� �������� �������� �� �����
select d.deccription, TRUNC(cl.admdate), count(cl.calcid) from ws_common_logs  cl, ws_dct_reqsourcetype d
where 1 = 1
--and cl.admdate between to_date('08.01.2018','dd.mm.yyyy') and to_date('10.01.2018','dd.mm.yyyy')
and cl.admdate >= trunc(sysdate) - 1
and d.id = cl.calcreqsourcetypeid
group by d.deccription,TRUNC(cl.admdate)
order by TRUNC(cl.admdate),  count(cl.calcid) desc;

--������� ���� � ����� ����� � �� ���������� � ������
select cl.calcid from ws_calc_logs_new cl
where cl.calcid not in (select cln.calcid from ws_common_logs cln);

--���������� �����  ��� ���������
select TRUNC(cl.admdate) as rasdate, cln.caryear, cln.insurer as PrevInsurer, cln.owner_region as OwnerRegion, cl.purchaseregion, count(cl.calcid)as calc_count
from webauto.ws_common_logs cl, webauto.ws_calc_logs_new cln
where 1 = 1
and cl.calcid = cln.calcid
and cl.calcreqsourcetypeid = 1
and cln.casco = '�'
and cl.admdate >= to_date('01.01.2017','dd.mm.yyyy');
group by TRUNC(cl.admdate), cln.caryear, cln.insurer, cln.owner_region, cl.purchaseregion
order by TRUNC(cl.admdate),  count(cl.calcid) desc;

 
--��� ������ �� ������� �� ������
select cl.calcid, cl.admdate,convert((cl.requestmessage),'CL8MSWIN1251','UTF8'),cl.pdate, cln.caryear, cln.autorace,cln.isanothersk,cln.insurer, cln.carpurchasedate, cc.value as audatex   
from webauto.ws_common_logs cl, webauto.ws_calc_logs_new cln,  webauto.ws_coeff_calc cc
where 1 = 1
and cl.calcid in (169234100,169234204) 
and cl.calcid = cln.calcid
and cc.calcid = cl.calcid
and cc.coefid = 49
order by cl.admdate desc;    

--����� ������� 
select cl.admdate, cl.client_ip, cl.*, cln.* 
from webauto.ws_common_logs cl, webauto.ws_calc_logs_new cln
where 1 = 1
and cl.calcid = cln.calcid
and cl.calcreqsourcetypeid = 4
and cln.policy = 1372824107
and cl.admdate >= trunc(sysdate)
order by cl.admdate desc; 
