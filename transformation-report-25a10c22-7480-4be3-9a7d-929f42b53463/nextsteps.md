# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to confirm there are no runtime exceptions that were not caught at compile time.

### 5. Execute Unit Tests

If the solution contains test projects, run all tests to validate functional correctness:

```bash
dotnet test
```

Review the test results and investigate any failures. Pay particular attention to tests covering data access, authentication, or any areas that commonly differ between .NET Framework and cross-platform .NET.

### 6. Check for Windows-Specific APIs

Even without build errors, some APIs may have been available at compile time but will fail at runtime on non-Windows platforms. Review the code for usage of the following:

- `System.Web` namespaces (these are not available in cross-platform .NET)
- Windows Registry access (`Microsoft.Win32.Registry`)
- Windows-specific file path assumptions (e.g., backslash separators)
- `System.Drawing` without the `System.Drawing.Common` NuGet package

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to assist with identifying these issues.

### 7. Review Configuration Files

Ensure that any configuration previously held in `Web.config` or `App.config` has been properly migrated to `appsettings.json` or `appsettings.{Environment}.json`. Verify that the application reads these values correctly at runtime using `IConfiguration`.

### 8. Validate Static Assets and Middleware

If `GadgetsOnline` is a web application, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Test all major routes and endpoints manually or through integration tests.

### 9. Publish the Application

Once local validation is complete, produce a published output to verify the deployment artifact builds correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files, assets, and dependencies are present before deploying to the target environment.