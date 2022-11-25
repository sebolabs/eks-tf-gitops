-- DOCS: https://docs.aws.amazon.com/athena/latest/ug/vpc-flow-logs.html

CREATE EXTERNAL TABLE IF NOT EXISTS `vpc_flow_logs` (
  `account_id` string, 
  `region` string, 
  `vpc_id` string, 
  `subnet_id` string, 
  `az_id` string, 
  `instance_id` string, 
  `interface_id` string, 
  `flow_direction` string, 
  `traffic_path` int, 
  `srcaddr` string, 
  `pkt_srcaddr` string, 
  `pkt_src_aws_service` string, 
  `srcport` int, 
  `dstaddr` string, 
  `pkt_dstaddr` string, 
  `pkt_dst_aws_service` string, 
  `dstport` int, 
  `protocol` bigint, 
  `type` string, 
  `tcp_flags` int, 
  `packets` bigint, 
  `bytes` bigint, 
  `start` bigint, 
  `end` bigint, 
  `action` string, 
  `log_status` string
)
PARTITIONED BY (`date` date)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
LOCATION 's3://<bucket name>/AWSLogs/<account id>/vpcflowlogs/<region>/'
TBLPROPERTIES ("skip.header.line.count"="1");

ALTER TABLE vpc_flow_logs
ADD PARTITION (`date`='<YYYY>-<MM>-<dd>')
LOCATION 's3://<bucket name>/AWSLogs/<account id>/vpcflowlogs/<region>/<YYYY>/<MM>/<dd>';

SELECT * 
FROM vpc_flow_logs 
WHERE date = DATE('<YYYY>-<MM>-<dd>') 
LIMIT 100;

ALTER TABLE vpc_flow_logs
DROP PARTITION (`date`='<YYYY>-<MM>-<dd>')

DROP TABLE `vpc_flow_logs`;
