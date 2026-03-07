#!/usr/bin/env bash
# Usage: ./verify_endpoints.sh <ALB_DNS>

ALB_DNS="$1"
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

# ALB checks
check "ALB /service-a" "http://$ALB_DNS/service-a/health"
check "ALB /service-b" "http://$ALB_DNS/service-b/health"

exit $FAILED
