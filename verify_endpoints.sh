#!/usr/bin/env bash
# Usage: ./verify_endpoints.sh <INSTANCE1_IP> <INSTANCE2_IP> <ALB_DNS>

INSTANCE1_IP="$1"
INSTANCE2_IP="$2"
ALB_DNS="$3"

FAILED=0

check() {
    echo -n "Checking $1 ... "
    if curl -s "$2" > /dev/null; then
        echo "OK"
    else
        echo "FAIL"
        FAILED=1
    fi
}

# EC2 direct checks
check "Instance1 Service-A" "http://$INSTANCE1_IP:8080/health"
check "Instance1 Service-B" "http://$INSTANCE1_IP:8081/health"
check "Instance2 Service-A" "http://$INSTANCE2_IP:8080/health"
check "Instance2 Service-B" "http://$INSTANCE2_IP:8081/health"

# ALB checks
check "ALB /service-a" "http://$ALB_DNS/service-a/health"
check "ALB /service-b" "http://$ALB_DNS/service-b/health"
check "ALB root"       "http://$ALB_DNS/"

exit $FAILED
