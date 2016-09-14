function isArray(obj) {
            return Object.prototype.toString.call(obj) === '[object Array]';
            }


function isStr() {
    if (format.__obj) return format.isKindOfClass(require(‘NSString’).class())
        else return typeof format == ‘string’
}