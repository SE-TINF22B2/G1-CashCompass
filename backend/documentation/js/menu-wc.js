'use strict';

customElements.define('compodoc-menu', class extends HTMLElement {
    constructor() {
        super();
        this.isNormalMode = this.getAttribute('mode') === 'normal';
    }

    connectedCallback() {
        this.render(this.isNormalMode);
    }

    render(isNormalMode) {
        let tp = lithtml.html(`
        <nav>
            <ul class="list">
                <li class="title">
                    <a href="index.html" data-type="index-link">backend documentation</a>
                </li>

                <li class="divider"></li>
                ${ isNormalMode ? `<div id="book-search-input" role="search"><input type="text" placeholder="Type to search"></div>` : '' }
                <li class="chapter">
                    <a data-type="chapter-link" href="index.html"><span class="icon ion-ios-home"></span>Getting started</a>
                    <ul class="links">
                        <li class="link">
                            <a href="overview.html" data-type="chapter-link">
                                <span class="icon ion-ios-keypad"></span>Overview
                            </a>
                        </li>
                        <li class="link">
                            <a href="index.html" data-type="chapter-link">
                                <span class="icon ion-ios-paper"></span>README
                            </a>
                        </li>
                                <li class="link">
                                    <a href="dependencies.html" data-type="chapter-link">
                                        <span class="icon ion-ios-list"></span>Dependencies
                                    </a>
                                </li>
                                <li class="link">
                                    <a href="properties.html" data-type="chapter-link">
                                        <span class="icon ion-ios-apps"></span>Properties
                                    </a>
                                </li>
                    </ul>
                </li>
                    <li class="chapter modules">
                        <a data-type="chapter-link" href="modules.html">
                            <div class="menu-toggler linked" data-bs-toggle="collapse" ${ isNormalMode ?
                                'data-bs-target="#modules-links"' : 'data-bs-target="#xs-modules-links"' }>
                                <span class="icon ion-ios-archive"></span>
                                <span class="link-name">Modules</span>
                                <span class="icon ion-ios-arrow-down"></span>
                            </div>
                        </a>
                        <ul class="links collapse " ${ isNormalMode ? 'id="modules-links"' : 'id="xs-modules-links"' }>
                            <li class="link">
                                <a href="modules/AppModule.html" data-type="entity-link" >AppModule</a>
                                    <li class="chapter inner">
                                        <div class="simple menu-toggler" data-bs-toggle="collapse" ${ isNormalMode ?
                                            'data-bs-target="#controllers-links-module-AppModule-d74dd6529d696a0ace0eb39f01d028b9810780c5a1e3c6adb885dbdec2809ab0d97817ba22a4fdc2f1990ee9324704d50cd6134aefeb4846f02f8715ee1a6926"' : 'data-bs-target="#xs-controllers-links-module-AppModule-d74dd6529d696a0ace0eb39f01d028b9810780c5a1e3c6adb885dbdec2809ab0d97817ba22a4fdc2f1990ee9324704d50cd6134aefeb4846f02f8715ee1a6926"' }>
                                            <span class="icon ion-md-swap"></span>
                                            <span>Controllers</span>
                                            <span class="icon ion-ios-arrow-down"></span>
                                        </div>
                                        <ul class="links collapse" ${ isNormalMode ? 'id="controllers-links-module-AppModule-d74dd6529d696a0ace0eb39f01d028b9810780c5a1e3c6adb885dbdec2809ab0d97817ba22a4fdc2f1990ee9324704d50cd6134aefeb4846f02f8715ee1a6926"' :
                                            'id="xs-controllers-links-module-AppModule-d74dd6529d696a0ace0eb39f01d028b9810780c5a1e3c6adb885dbdec2809ab0d97817ba22a4fdc2f1990ee9324704d50cd6134aefeb4846f02f8715ee1a6926"' }>
                                            <li class="link">
                                                <a href="controllers/AppController.html" data-type="entity-link" data-context="sub-entity" data-context-id="modules" >AppController</a>
                                            </li>
                                        </ul>
                                    </li>
                                <li class="chapter inner">
                                    <div class="simple menu-toggler" data-bs-toggle="collapse" ${ isNormalMode ?
                                        'data-bs-target="#injectables-links-module-AppModule-d74dd6529d696a0ace0eb39f01d028b9810780c5a1e3c6adb885dbdec2809ab0d97817ba22a4fdc2f1990ee9324704d50cd6134aefeb4846f02f8715ee1a6926"' : 'data-bs-target="#xs-injectables-links-module-AppModule-d74dd6529d696a0ace0eb39f01d028b9810780c5a1e3c6adb885dbdec2809ab0d97817ba22a4fdc2f1990ee9324704d50cd6134aefeb4846f02f8715ee1a6926"' }>
                                        <span class="icon ion-md-arrow-round-down"></span>
                                        <span>Injectables</span>
                                        <span class="icon ion-ios-arrow-down"></span>
                                    </div>
                                    <ul class="links collapse" ${ isNormalMode ? 'id="injectables-links-module-AppModule-d74dd6529d696a0ace0eb39f01d028b9810780c5a1e3c6adb885dbdec2809ab0d97817ba22a4fdc2f1990ee9324704d50cd6134aefeb4846f02f8715ee1a6926"' :
                                        'id="xs-injectables-links-module-AppModule-d74dd6529d696a0ace0eb39f01d028b9810780c5a1e3c6adb885dbdec2809ab0d97817ba22a4fdc2f1990ee9324704d50cd6134aefeb4846f02f8715ee1a6926"' }>
                                        <li class="link">
                                            <a href="injectables/AppService.html" data-type="entity-link" data-context="sub-entity" data-context-id="modules" >AppService</a>
                                        </li>
                                    </ul>
                                </li>
                            </li>
                            <li class="link">
                                <a href="modules/AuthModule.html" data-type="entity-link" >AuthModule</a>
                                    <li class="chapter inner">
                                        <div class="simple menu-toggler" data-bs-toggle="collapse" ${ isNormalMode ?
                                            'data-bs-target="#controllers-links-module-AuthModule-b75446a83e480d3666638bd85f1b27888553827b61e06b94c35879c4dffc97b96fff4f6db1e064c198f64b494f817ef8706940d83b39de789edcc7d611b0ddad"' : 'data-bs-target="#xs-controllers-links-module-AuthModule-b75446a83e480d3666638bd85f1b27888553827b61e06b94c35879c4dffc97b96fff4f6db1e064c198f64b494f817ef8706940d83b39de789edcc7d611b0ddad"' }>
                                            <span class="icon ion-md-swap"></span>
                                            <span>Controllers</span>
                                            <span class="icon ion-ios-arrow-down"></span>
                                        </div>
                                        <ul class="links collapse" ${ isNormalMode ? 'id="controllers-links-module-AuthModule-b75446a83e480d3666638bd85f1b27888553827b61e06b94c35879c4dffc97b96fff4f6db1e064c198f64b494f817ef8706940d83b39de789edcc7d611b0ddad"' :
                                            'id="xs-controllers-links-module-AuthModule-b75446a83e480d3666638bd85f1b27888553827b61e06b94c35879c4dffc97b96fff4f6db1e064c198f64b494f817ef8706940d83b39de789edcc7d611b0ddad"' }>
                                            <li class="link">
                                                <a href="controllers/AuthController.html" data-type="entity-link" data-context="sub-entity" data-context-id="modules" >AuthController</a>
                                            </li>
                                        </ul>
                                    </li>
                                <li class="chapter inner">
                                    <div class="simple menu-toggler" data-bs-toggle="collapse" ${ isNormalMode ?
                                        'data-bs-target="#injectables-links-module-AuthModule-b75446a83e480d3666638bd85f1b27888553827b61e06b94c35879c4dffc97b96fff4f6db1e064c198f64b494f817ef8706940d83b39de789edcc7d611b0ddad"' : 'data-bs-target="#xs-injectables-links-module-AuthModule-b75446a83e480d3666638bd85f1b27888553827b61e06b94c35879c4dffc97b96fff4f6db1e064c198f64b494f817ef8706940d83b39de789edcc7d611b0ddad"' }>
                                        <span class="icon ion-md-arrow-round-down"></span>
                                        <span>Injectables</span>
                                        <span class="icon ion-ios-arrow-down"></span>
                                    </div>
                                    <ul class="links collapse" ${ isNormalMode ? 'id="injectables-links-module-AuthModule-b75446a83e480d3666638bd85f1b27888553827b61e06b94c35879c4dffc97b96fff4f6db1e064c198f64b494f817ef8706940d83b39de789edcc7d611b0ddad"' :
                                        'id="xs-injectables-links-module-AuthModule-b75446a83e480d3666638bd85f1b27888553827b61e06b94c35879c4dffc97b96fff4f6db1e064c198f64b494f817ef8706940d83b39de789edcc7d611b0ddad"' }>
                                        <li class="link">
                                            <a href="injectables/AuthService.html" data-type="entity-link" data-context="sub-entity" data-context-id="modules" >AuthService</a>
                                        </li>
                                        <li class="link">
                                            <a href="injectables/GoogleStrategy.html" data-type="entity-link" data-context="sub-entity" data-context-id="modules" >GoogleStrategy</a>
                                        </li>
                                        <li class="link">
                                            <a href="injectables/JwtStrategy.html" data-type="entity-link" data-context="sub-entity" data-context-id="modules" >JwtStrategy</a>
                                        </li>
                                    </ul>
                                </li>
                            </li>
                            <li class="link">
                                <a href="modules/MailModule.html" data-type="entity-link" >MailModule</a>
                                <li class="chapter inner">
                                    <div class="simple menu-toggler" data-bs-toggle="collapse" ${ isNormalMode ?
                                        'data-bs-target="#injectables-links-module-MailModule-dbab8395e8cd912d4f8df91362d0facafb821f315d3c05a40cc1984056d3d0d4ba5e9161631ee8bd8e901f641ffa8ba64b9fc504c5ac6625057fd54d2eb3f962"' : 'data-bs-target="#xs-injectables-links-module-MailModule-dbab8395e8cd912d4f8df91362d0facafb821f315d3c05a40cc1984056d3d0d4ba5e9161631ee8bd8e901f641ffa8ba64b9fc504c5ac6625057fd54d2eb3f962"' }>
                                        <span class="icon ion-md-arrow-round-down"></span>
                                        <span>Injectables</span>
                                        <span class="icon ion-ios-arrow-down"></span>
                                    </div>
                                    <ul class="links collapse" ${ isNormalMode ? 'id="injectables-links-module-MailModule-dbab8395e8cd912d4f8df91362d0facafb821f315d3c05a40cc1984056d3d0d4ba5e9161631ee8bd8e901f641ffa8ba64b9fc504c5ac6625057fd54d2eb3f962"' :
                                        'id="xs-injectables-links-module-MailModule-dbab8395e8cd912d4f8df91362d0facafb821f315d3c05a40cc1984056d3d0d4ba5e9161631ee8bd8e901f641ffa8ba64b9fc504c5ac6625057fd54d2eb3f962"' }>
                                        <li class="link">
                                            <a href="injectables/MailService.html" data-type="entity-link" data-context="sub-entity" data-context-id="modules" >MailService</a>
                                        </li>
                                    </ul>
                                </li>
                            </li>
                            <li class="link">
                                <a href="modules/MockEntityModule.html" data-type="entity-link" >MockEntityModule</a>
                                    <li class="chapter inner">
                                        <div class="simple menu-toggler" data-bs-toggle="collapse" ${ isNormalMode ?
                                            'data-bs-target="#controllers-links-module-MockEntityModule-a5e6e08ef4c8ac52e42c4216056aa1fddb60a3224f02ff1beb03c2dc613d8df07d96d96e82da201099ca8f1b5b9a98ef37bb1a2e444d2a75d96c954a91b98d36"' : 'data-bs-target="#xs-controllers-links-module-MockEntityModule-a5e6e08ef4c8ac52e42c4216056aa1fddb60a3224f02ff1beb03c2dc613d8df07d96d96e82da201099ca8f1b5b9a98ef37bb1a2e444d2a75d96c954a91b98d36"' }>
                                            <span class="icon ion-md-swap"></span>
                                            <span>Controllers</span>
                                            <span class="icon ion-ios-arrow-down"></span>
                                        </div>
                                        <ul class="links collapse" ${ isNormalMode ? 'id="controllers-links-module-MockEntityModule-a5e6e08ef4c8ac52e42c4216056aa1fddb60a3224f02ff1beb03c2dc613d8df07d96d96e82da201099ca8f1b5b9a98ef37bb1a2e444d2a75d96c954a91b98d36"' :
                                            'id="xs-controllers-links-module-MockEntityModule-a5e6e08ef4c8ac52e42c4216056aa1fddb60a3224f02ff1beb03c2dc613d8df07d96d96e82da201099ca8f1b5b9a98ef37bb1a2e444d2a75d96c954a91b98d36"' }>
                                            <li class="link">
                                                <a href="controllers/MockEntityController.html" data-type="entity-link" data-context="sub-entity" data-context-id="modules" >MockEntityController</a>
                                            </li>
                                        </ul>
                                    </li>
                                <li class="chapter inner">
                                    <div class="simple menu-toggler" data-bs-toggle="collapse" ${ isNormalMode ?
                                        'data-bs-target="#injectables-links-module-MockEntityModule-a5e6e08ef4c8ac52e42c4216056aa1fddb60a3224f02ff1beb03c2dc613d8df07d96d96e82da201099ca8f1b5b9a98ef37bb1a2e444d2a75d96c954a91b98d36"' : 'data-bs-target="#xs-injectables-links-module-MockEntityModule-a5e6e08ef4c8ac52e42c4216056aa1fddb60a3224f02ff1beb03c2dc613d8df07d96d96e82da201099ca8f1b5b9a98ef37bb1a2e444d2a75d96c954a91b98d36"' }>
                                        <span class="icon ion-md-arrow-round-down"></span>
                                        <span>Injectables</span>
                                        <span class="icon ion-ios-arrow-down"></span>
                                    </div>
                                    <ul class="links collapse" ${ isNormalMode ? 'id="injectables-links-module-MockEntityModule-a5e6e08ef4c8ac52e42c4216056aa1fddb60a3224f02ff1beb03c2dc613d8df07d96d96e82da201099ca8f1b5b9a98ef37bb1a2e444d2a75d96c954a91b98d36"' :
                                        'id="xs-injectables-links-module-MockEntityModule-a5e6e08ef4c8ac52e42c4216056aa1fddb60a3224f02ff1beb03c2dc613d8df07d96d96e82da201099ca8f1b5b9a98ef37bb1a2e444d2a75d96c954a91b98d36"' }>
                                        <li class="link">
                                            <a href="injectables/MailService.html" data-type="entity-link" data-context="sub-entity" data-context-id="modules" >MailService</a>
                                        </li>
                                        <li class="link">
                                            <a href="injectables/MockEntityService.html" data-type="entity-link" data-context="sub-entity" data-context-id="modules" >MockEntityService</a>
                                        </li>
                                    </ul>
                                </li>
                            </li>
                </ul>
                </li>
                    <li class="chapter">
                        <div class="simple menu-toggler" data-bs-toggle="collapse" ${ isNormalMode ? 'data-bs-target="#classes-links"' :
                            'data-bs-target="#xs-classes-links"' }>
                            <span class="icon ion-ios-paper"></span>
                            <span>Classes</span>
                            <span class="icon ion-ios-arrow-down"></span>
                        </div>
                        <ul class="links collapse " ${ isNormalMode ? 'id="classes-links"' : 'id="xs-classes-links"' }>
                            <li class="link">
                                <a href="classes/AuthDto.html" data-type="entity-link" >AuthDto</a>
                            </li>
                            <li class="link">
                                <a href="classes/CreateMockEntityDto.html" data-type="entity-link" >CreateMockEntityDto</a>
                            </li>
                            <li class="link">
                                <a href="classes/JwtGuard.html" data-type="entity-link" >JwtGuard</a>
                            </li>
                            <li class="link">
                                <a href="classes/MockEntity.html" data-type="entity-link" >MockEntity</a>
                            </li>
                            <li class="link">
                                <a href="classes/MockEntity-1.html" data-type="entity-link" >MockEntity</a>
                            </li>
                            <li class="link">
                                <a href="classes/UpdateMockEntityDto.html" data-type="entity-link" >UpdateMockEntityDto</a>
                            </li>
                            <li class="link">
                                <a href="classes/User.html" data-type="entity-link" >User</a>
                            </li>
                            <li class="link">
                                <a href="classes/User-1.html" data-type="entity-link" >User</a>
                            </li>
                        </ul>
                    </li>
                        <li class="chapter">
                            <div class="simple menu-toggler" data-bs-toggle="collapse" ${ isNormalMode ? 'data-bs-target="#injectables-links"' :
                                'data-bs-target="#xs-injectables-links"' }>
                                <span class="icon ion-md-arrow-round-down"></span>
                                <span>Injectables</span>
                                <span class="icon ion-ios-arrow-down"></span>
                            </div>
                            <ul class="links collapse " ${ isNormalMode ? 'id="injectables-links"' : 'id="xs-injectables-links"' }>
                                <li class="link">
                                    <a href="injectables/GoogleOauthGuard.html" data-type="entity-link" >GoogleOauthGuard</a>
                                </li>
                                <li class="link">
                                    <a href="injectables/GoogleStrategy.html" data-type="entity-link" >GoogleStrategy</a>
                                </li>
                                <li class="link">
                                    <a href="injectables/JwtStrategy.html" data-type="entity-link" >JwtStrategy</a>
                                </li>
                            </ul>
                        </li>
                    <li class="chapter">
                        <div class="simple menu-toggler" data-bs-toggle="collapse" ${ isNormalMode ? 'data-bs-target="#miscellaneous-links"'
                            : 'data-bs-target="#xs-miscellaneous-links"' }>
                            <span class="icon ion-ios-cube"></span>
                            <span>Miscellaneous</span>
                            <span class="icon ion-ios-arrow-down"></span>
                        </div>
                        <ul class="links collapse " ${ isNormalMode ? 'id="miscellaneous-links"' : 'id="xs-miscellaneous-links"' }>
                            <li class="link">
                                <a href="miscellaneous/functions.html" data-type="entity-link">Functions</a>
                            </li>
                            <li class="link">
                                <a href="miscellaneous/typealiases.html" data-type="entity-link">Type aliases</a>
                            </li>
                            <li class="link">
                                <a href="miscellaneous/variables.html" data-type="entity-link">Variables</a>
                            </li>
                        </ul>
                    </li>
                    <li class="chapter">
                        <a data-type="chapter-link" href="coverage.html"><span class="icon ion-ios-stats"></span>Documentation coverage</a>
                    </li>
                    <li class="divider"></li>
                    <li class="copyright">
                        Documentation generated using <a href="https://compodoc.app/" target="_blank" rel="noopener noreferrer">
                            <img data-src="images/compodoc-vectorise.png" class="img-responsive" data-type="compodoc-logo">
                        </a>
                    </li>
            </ul>
        </nav>
        `);
        this.innerHTML = tp.strings;
    }
});