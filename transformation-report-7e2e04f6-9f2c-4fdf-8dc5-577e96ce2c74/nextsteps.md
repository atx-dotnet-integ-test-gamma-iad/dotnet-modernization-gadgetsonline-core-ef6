# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, such as `net8.0`. If it is set to an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and verify that core functionality behaves as expected compared to the legacy version.

### 5. Execute Existing Tests

If the solution contains any test projects, run them to validate functional correctness:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they indicate regressions introduced during the migration or pre-existing issues.

### 6. Check for Removed or Changed APIs

Cross-platform .NET removes certain Windows-specific or legacy APIs that were available in .NET Framework. Review the code for usage of the following common problem areas:

- `System.Web` namespace references (not available in cross-platform .NET)
- `HttpContext` usage outside of the ASP.NET Core request pipeline
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows Registry access (`Microsoft.Win32.Registry`)
- Binary formatters (`BinaryFormatter` is obsolete and disabled by default)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify remaining compatibility issues.

### 7. Validate Configuration Files

Ensure that any `web.config` or `app.config` settings have been properly migrated to `appsettings.json` or environment-based configuration. Confirm that connection strings, application settings, and any custom configuration sections are accessible at runtime.

### 8. Verify Static Files and Middleware

If `GadgetsOnline` is a web application, confirm that static file serving, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs` according to ASP.NET Core conventions.

### 9. Test on Target Operating Systems

Since the goal is cross-platform support, run the application on each intended operating system (e.g., Windows, Linux, macOS) to identify any platform-specific runtime issues:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Adjust the `--runtime` identifier as appropriate for your target platform.

### 10. Review Published Output

Publish the application and inspect the output directory to confirm all required files, assets, and dependencies are present:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` folder before deploying to the target environment.